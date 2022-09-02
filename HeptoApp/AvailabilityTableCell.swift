//
//  AvailabilityTableCell.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//
protocol DropdownDelegate:AnyObject{
    func dropdownShow(button:UIButton,width:CGFloat,section:Int)
    func rightDropdown(button:UIButton,width:CGFloat,section:Int)
}
import UIKit

class AvailabilityTableCell: UITableViewCell {
    @IBOutlet var day_lbl:UILabel!
    @IBOutlet var days_view:CustomView!
    @IBOutlet var timing_Collection:UICollectionView!
    var sections = 0
    var ref_delegate:RefreshDelegate?
    var drop_delegate:DropdownDelegate?
    var start_time = 0
    var end_time = 0
    var width = 170.0
    override func awakeFromNib() {
        super.awakeFromNib()
        timing_Collection.register(UINib(nibName: "TimingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TimingCollectionCell")
        timing_Collection.dataSource = self
        timing_Collection.delegate = self
        timing_Collection.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func AddTimingAction(_ sender:UIButton){
        let start = AvailabilityViewController.availabilityList[sections].timings[AvailabilityViewController.availabilityList[sections].timings.count-1].start
        let end = AvailabilityViewController.availabilityList[sections].timings[AvailabilityViewController.availabilityList[sections].timings.count-1].end
        start_time = Int(start) ?? 1 < 23 ? Int(start)!+2 : 00
        end_time = Int(end) ?? 1 < 23 ? Int(end)!+2 : 00
        if sender.tag == 0{
            AvailabilityViewController.availabilityList[sections].timings.insert(Timings(start: "\(start_time)", end: "\(end_time)"),at:AvailabilityViewController.availabilityList[sections].timings.count)
        }
        else{
            AvailabilityViewController.availabilityList[sections].timings.remove(at: sender.tag)
        }
        if ref_delegate != nil {
            ref_delegate?.RefreshAction()
        }
        timing_Collection.reloadData()
    }
    @objc func dropDownAction(_ sender:UIButton){
        if drop_delegate != nil{
            drop_delegate?.dropdownShow(button: sender, width: width,section: sections)
        }
    }
    @objc func rightDropDownAction(_ sender:UIButton){
        if drop_delegate != nil{
            drop_delegate?.rightDropdown(button: sender, width: width,section: sections)
        }
    }
}
extension AvailabilityTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return AvailabilityViewController.availabilityList[sections].timings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timing_Collection.dequeueReusableCell(withReuseIdentifier: "TimingCollectionCell", for: indexPath) as! TimingCollectionCell
        let start = AvailabilityViewController.availabilityList[sections].timings[indexPath.row].start
        let end = AvailabilityViewController.availabilityList[sections].timings[indexPath.row].end
        let startTiming = Int(start) ?? 1 < 12 ? "AM":"PM"
        let endTiming = Int(end) ?? 1 < 12 ? "AM":"PM"
        cell.start_time_lbl.text = start + ":00 " + startTiming
        cell.end_time_lbl.text = end + ":00 " + endTiming
        cell.add_img.image = indexPath.row == 0 ? UIImage(named: "Plus"):UIImage(named: "Minus")
        cell.add_btn.tag = indexPath.row
        cell.drop1_btn.tag = indexPath.row
        cell.drop2_btn.tag = indexPath.row
        width = cell.start_view.frame.width
        cell.add_btn.addTarget(self, action: #selector(AddTimingAction(_:)), for: .touchUpInside)
        cell.drop1_btn.addTarget(self, action: #selector(dropDownAction(_:)), for: .touchUpInside)
        cell.drop2_btn.addTarget(self, action: #selector(rightDropDownAction(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: timing_Collection.frame.size.width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
//class TriangleView : UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func draw(_ rect: CGRect) {
//
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        context.beginPath()
//        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
//        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
//        context.closePath()
//        context.setFillColor(UIColor.systemBackground.cgColor)
//     //   context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
//        context.fillPath()
//    }
//}
