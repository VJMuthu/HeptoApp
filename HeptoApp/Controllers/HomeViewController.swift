//
//  HomeViewController.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import Foundation
import UIKit
class HomeViewController:UIViewController,UITextFieldDelegate{
    @IBOutlet weak var table_View:UITableView!
    @IBOutlet weak var search_Field:UITextField!
    var sections = 0
    var isSearch = false
    var searchText = ""
    static var searchList = [ServiceModel]()
    static var serviceList = [ServiceModel]()
    lazy var serviceVM:ServiceViewModel = {
        return ServiceViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dash Board"
        table_View.register(UINib(nibName: "BannerTableCell", bundle: nil), forCellReuseIdentifier: "BannerTableCell")
        table_View.register(UINib(nibName: "ServiceTableCell", bundle: nil), forCellReuseIdentifier: "ServiceTableCell")
        table_View.dataSource = self
        table_View.delegate = self
        search_Field.delegate = self
        HomeViewController.serviceList = serviceVM.getServices()
        table_View.reloadData()
    }
//MARK: - TextField Delegate Function
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSearch = true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        isSearch = false
        table_View.reloadData()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isSearch = false
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchText = search_Field.text!
        if searchText.count == 0 {
            isSearch = false
            self.table_View.reloadData()
        } else {
            HomeViewController.searchList.removeAll()
            for form in HomeViewController.serviceList{
                let temp =   form.title.range(of:searchText,options: .caseInsensitive) != nil
                let tem1 = form.service.filter { (form1) -> Bool in form1.title.range(of:searchText,options: .caseInsensitive) != nil
            }
                if temp == true || tem1.count>0{
                    HomeViewController.searchList.append(ServiceModel(title: form.title, image: form.image, service: tem1))
                }
            }
            if(HomeViewController.searchList.count == 0){
                isSearch = true

            } else {
                isSearch = true
            }
            self.table_View.reloadData()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search_Field.resignFirstResponder()
        return true
    }

    @IBAction func LogOutAction(_ barbutton:UIBarButtonItem){
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to Logout ?", preferredStyle: UIAlertController.Style.alert)
                alert.view.tintColor = UIColor.red
                alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: {
                    action in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {
                    action in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let rootViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    UserDefaults.standard.removeObject(forKey: "UserName")
                    navigationController.viewControllers = [rootViewController]
                    UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = navigationController
                    UIApplication.shared.windows.first { $0.isKeyWindow }?.makeKeyAndVisible()
                }))
                self.present(alert, animated: false, completion: nil)
    }
}
extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
           return 1
        }
        else{
            if isSearch{
                return HomeViewController.searchList.count
            }
            else{
            return HomeViewController.serviceList.count
            }
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0{
            let cell = table_View.dequeueReusableCell(withIdentifier: "BannerTableCell", for: indexPath) as! BannerTableCell
            return cell
        }
        else{
            let cell = table_View.dequeueReusableCell(withIdentifier: "ServiceTableCell", for: indexPath) as! ServiceTableCell
            if isSearch {
                cell.isSearch = true
                cell.service_title.text = HomeViewController.searchList[indexPath.row].title
                cell.service_img.image = UIImage(named: HomeViewController.searchList[indexPath.row].image)
                cell.service_img.contentMode = .scaleAspectFit
                cell.sections = indexPath.row
            }
            else{
            cell.isSearch = false
            cell.service_title.text = HomeViewController.serviceList[indexPath.row].title
            cell.service_img.image = UIImage(named: HomeViewController.serviceList[indexPath.row].image)
            cell.service_img.contentMode = .scaleAspectFit
            cell.sections = indexPath.row
            }
            cell.service_Collection.reloadData()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 150
        }
        else{
            return 120
        }
    }
    
}
