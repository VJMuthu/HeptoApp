//
//  ViewController.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: - Getstarted Action
    @IBAction func getStartedAction(_ sender:UIButton){
        let regisVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(regisVC, animated: true)
    }
}

extension UIViewController{
    var storyboard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
