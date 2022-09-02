//
//  AvailabilityViewController.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//
protocol RefreshDelegate:AnyObject{
    func RefreshAction()
}
import Foundation
import UIKit
class AvailabilityViewController:UIViewController,RefreshDelegate,DropdownDelegate{
    
    @IBOutlet weak var save_View:UIView!
    @IBOutlet weak var table_View:UITableView!
    @IBOutlet weak var table_height:NSLayoutConstraint!
    @IBOutlet weak var drop_View:DropdownView!
    static var availabilityList = [ActivityModel]()
    lazy var availabilityVM:ActivityViewModel = {
       return ActivityViewModel()
    }()
    var selected_Index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Availability"
        save_View.layer.cornerRadius = 12.5
        save_View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        table_View.register(UINib(nibName: "AvailabilityTableCell", bundle: nil), forCellReuseIdentifier: "AvailabilityTableCell")
        table_View.dataSource = self
        table_View.delegate = self
        AvailabilityViewController.availabilityList = availabilityVM.getAvailability()
        drop_View.isHidden = true
        drop_View.cancel_btn.addTarget(self, action: #selector(CancelAction(_:)), for: .touchUpInside)
        drop_View.am_btn.addTarget(self, action: #selector(AmAction(_:)), for: .touchUpInside)
        drop_View.pm_btn.addTarget(self, action: #selector(PmAction(_:)), for: .touchUpInside)
        drop_View.done_btn.addTarget(self, action: #selector(DoneAction(_:)), for: .touchUpInside)
        drop_View.down1_btn.addTarget(self, action: #selector(DownAction(_:)), for: .touchUpInside)
        drop_View.down2_btn.addTarget(self, action: #selector(DownAction(_:)), for: .touchUpInside)
        drop_View.up1_btn.addTarget(self, action: #selector(UpAction(_:)), for: .touchUpInside)
        drop_View.up2_btn.addTarget(self, action: #selector(UpAction(_:)), for: .touchUpInside)

        table_View.reloadData()
    }
    override func viewDidLayoutSubviews() {
        table_height.constant = table_View.contentSize.height
    }
    func RefreshAction(){
        viewDidLayoutSubviews()
        table_View.reloadData()
    }
    func dropdownShow(button:UIButton, width: CGFloat,section:Int) {
        var count = 0
        for j in 0..<section{
                if AvailabilityViewController.availabilityList[j].timings.count > 1{
                    count += AvailabilityViewController.availabilityList[j].timings.count
            }
        }
        drop_View.frame = CGRect(x: button.frame.origin.x-(width*0.075), y: 52 + (52 * CGFloat(count+section+1+button.tag)), width: width*1.4, height: width*2.5)
        drop_View.layer.cornerRadius = 10
        drop_View.layer.shadowRadius = 5
        drop_View.layer.shadowColor = UIColor.lightGray.cgColor
        drop_View.layer.shadowOffset = CGSize.zero
        drop_View.layer.shadowOpacity = 0.5
        drop_View.isHidden = false

    }
    func rightDropdown(button:UIButton,width:CGFloat,section:Int){
        var count = 0
        for j in 0..<section{
                if AvailabilityViewController.availabilityList[j].timings.count > 1{
                    count += AvailabilityViewController.availabilityList[j].timings.count
            }
        }
        drop_View.frame = CGRect(x: button.frame.origin.x+width*1.575, y: 52 + (52 * CGFloat(count+section+1+button.tag)), width: width*1.4, height: width*2.5)
        drop_View.layer.cornerRadius = 10
        drop_View.layer.shadowRadius = 5
        drop_View.layer.shadowColor = UIColor.lightGray.cgColor
        drop_View.layer.shadowOffset = CGSize.zero
        drop_View.layer.shadowOpacity = 0.5
        drop_View.isHidden = false

    }
    @objc func CancelAction(_ sender:UIButton){
        drop_View.isHidden = true
    }
    @objc func PmAction(_ sender:UIButton){
        drop_View.am_view.backgroundColor = .lightGray
        drop_View.pm_view.backgroundColor = .systemOrange

    }
    @objc func AmAction(_ sender:UIButton){
        drop_View.am_view.backgroundColor = .systemOrange
        drop_View.pm_view.backgroundColor = .lightGray

    }
    @objc func DoneAction(_ sender:UIButton){
        drop_View.isHidden = true
    }
    @objc func DownAction(_ sender:UIButton){
        
    }
    @objc func UpAction(_ sender:UIButton){
        
    }
    
}
extension AvailabilityViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AvailabilityViewController.availabilityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_View.dequeueReusableCell(withIdentifier: "AvailabilityTableCell", for: indexPath) as! AvailabilityTableCell
        cell.day_lbl.text = AvailabilityViewController.availabilityList[indexPath.row].day
        cell.days_view.backgroundColor = selected_Index == indexPath.row ? UIColor(named: "Navigation"):UIColor.systemBackground
        cell.days_view.shadowColor = selected_Index == indexPath.row ? UIColor.clear:UIColor.lightGray
        cell.days_view.backgroundColor = selected_Index == indexPath.row ? UIColor(named: "Navigation"):UIColor.systemBackground
        cell.ref_delegate = self
        cell.drop_delegate = self
        cell.sections = indexPath.row
        cell.timing_Collection.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AvailabilityViewController.availabilityList[indexPath.row].timings.count * 52)
    }
    
}
