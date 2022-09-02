//
//  DropdownView.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import Foundation
import UIKit
class DropdownView:UIView{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cancel_btn: UIButton!
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var am_btn: UIButton!
    @IBOutlet weak var pm_btn: UIButton!
    @IBOutlet weak var am_view: UIView!
    @IBOutlet weak var pm_view: UIView!
    @IBOutlet weak var hrs_field: UITextField!
    @IBOutlet weak var mins_field: UITextField!
    @IBOutlet weak var up1_btn: UIButton!
    @IBOutlet weak var up2_btn: UIButton!
    @IBOutlet weak var down1_btn: UIButton!
    @IBOutlet weak var down2_btn: UIButton!



   // let view = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //call function

        loadNib()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadNib()

        //fatalError("init(coder:) has not been implemented")
    }

    func loadNib() {
        let bundle = Bundle(for: DropdownView.self)
        let nib = UINib(nibName: "DropdownView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view);
    }
}
