//
//  TrackViewController.swift
//  HeptoApp
//
//  Created by iOS on 26/08/22.
//
struct Routes:Codable{
    let routes:[Route]
}
struct Route:Codable{
let overview_polyline:OverviewPolyline
}
struct OverviewPolyline:Codable{
    let points:String
}
import Foundation
import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
class TrackViewController:UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate{
    @IBOutlet weak var map_View: GMSMapView!
    @IBOutlet weak var address_View: UIView!
    @IBOutlet weak var address_Lbl: UILabel!
    @IBOutlet weak var address_Height: NSLayoutConstraint!
    @IBOutlet weak var street_Field: UITextField!
    @IBOutlet weak var searchList_View:UIView!
    @IBOutlet weak var search_Field:UITextField!
    @IBOutlet weak var location_tbl:UITableView!
    let locationManager = CLLocationManager()
    var tableDataSource: GMSAutocompleteTableDataSource!
    var current_lat = Double()
    var current_lon = Double()
    var destination_lat = Double()
    var destination_lon = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map_View.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            map_View.isMyLocationEnabled = true
            map_View.settings.myLocationButton = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        map_View.padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        address_View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        address_View.layer.cornerRadius = 15
        search_Field.delegate = self
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        location_tbl.dataSource = tableDataSource
        location_tbl.delegate = tableDataSource
        searchList_View.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        address_Height.constant = 150.0 + address_Lbl.frame.size.height
    }
    @IBAction func ConfirmAction(_ sender: UIButton) {
        if street_Field.text != ""{
        address_Height.constant = 0
        address_View.isHidden = true
        //    getDirections()
        PolyLineDraw()
        }
    }
    func PolyLineDraw(){
        let origin = "\(current_lat),\(current_lon)"
        let destination = "\(destination_lat),\(destination_lon)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyBCg78mJnB6gwR6Sg00nVquvwYWHaHiAcg"
        let decoder = JSONDecoder()
        if let urls = URL(string: url){
             let data = try? Data(contentsOf: urls)
            let task = try! decoder.decode(Routes.self, from: data!)
            for route in task.routes{
                let points = route.overview_polyline.points
                let path = GMSPath.init(fromEncodedPath: points)
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = UIColor.red
                polyline.strokeWidth = 3.0
                polyline.map = map_View

            }
        
        }
    }
}
// MARK: - CLLocationManagerDelegate
extension TrackViewController:GMSAutocompleteTableDataSourceDelegate,UITextFieldDelegate {
    func locationManager(_ manager: CLLocationManager,didChangeAuthorization status:CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
        map_View.isMyLocationEnabled = true
        map_View.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations:[CLLocation]) {
        guard let location = locations.first else {
            return
        }
        map_View.camera = GMSCameraPosition(target: location.coordinate,zoom: 15,bearing: 0,viewingAngle: 0)
    }
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let lines = address.lines
            else {
                return
            }
            self.current_lat = coordinate.latitude
            self.current_lon = coordinate.longitude
            self.address_Lbl.text = lines.joined(separator: "\n")
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocode(coordinate: position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        //addressLabel.lock()
    }
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
     //   UIApplication.shared.isNetworkActivityIndicatorVisible = false
        location_tbl.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        location_tbl.reloadData()
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let searchText = textField.text
        searchList_View.isHidden = true
        if searchText!.count > 3{
            tableDataSource.sourceTextHasChanged(searchText)
            searchList_View.isHidden = false
        }
    }
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        print("Place:",place)
        destination_lat = place.coordinate.latitude
        destination_lon = place.coordinate.longitude
        street_Field.text = place.formattedAddress!
     //   map_View.camera = GMSCameraPosition(target: place.coordinate,zoom: 15,bearing: 0,viewingAngle: 0)

        
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        print("Error: \(error.localizedDescription)")
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        searchList_View.isHidden = true
        return true
    }
}
