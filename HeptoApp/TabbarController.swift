//
//  TabbarController.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import Foundation
import UIKit
class TabbarController:UITabBarController, UITabBarControllerDelegate{
    static private(set) var currentInstance:TabbarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        TabbarController.currentInstance = self
        delegate = self
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = viewController as? UINavigationController {
             vc.popToRootViewController(animated: false)
        }
        return true
    }
}
