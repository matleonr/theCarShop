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
        setNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
