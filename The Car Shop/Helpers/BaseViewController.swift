//
//  BaseViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    
   

    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//     }

}

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController?.childForStatusBarStyle ?? selectedViewController
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}
