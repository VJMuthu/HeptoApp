//
//  ServiceTableCell.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import UIKit

class ServiceTableCell: UITableViewCell {
    @IBOutlet var service_title:UILabel!
    @IBOutlet var service_img:UIImageView!
    @IBOutlet var service_Collection:UICollectionView!
    var sections = 0
    var isSearch = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        service_Collection.register(UINib(nibName: "ServiceCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionCell")
        service_Collection.delegate = self
        service_Collection.dataSource = self
        service_Collection.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension ServiceTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch == true {
            return HomeViewController.searchList[sections].service.count
        }
        else{
        return HomeViewController.serviceList[sections].service.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = service_Collection.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionCell", for: indexPath) as! ServiceCollectionCell
        if isSearch{
            cell.service_lbl.text = HomeViewController.searchList[sections].service[indexPath.row].title
            cell.service_img.image = UIImage(named: HomeViewController.searchList[sections].service[indexPath.row].image)

        }
        else{
        cell.service_lbl.text = HomeViewController.serviceList[sections].service[indexPath.row].title
        cell.service_img.image = UIImage(named: HomeViewController.serviceList[sections].service[indexPath.row].image)
        cell.service_img.contentMode = .scaleAspectFit
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: service_Collection.frame.size.height*0.85, height: service_Collection.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
