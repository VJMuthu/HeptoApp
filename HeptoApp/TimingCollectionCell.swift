//
//  TimingCollectionCell.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import UIKit

class TimingCollectionCell: UICollectionViewCell {
    @IBOutlet var add_btn:UIButton!
    @IBOutlet var add_img:UIImageView!
    @IBOutlet var start_time_lbl:UILabel!
    @IBOutlet var start_view:CustomView!
    @IBOutlet var end_time_lbl:UILabel!
    @IBOutlet var drop1_btn:UIButton!
    @IBOutlet var drop2_btn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
