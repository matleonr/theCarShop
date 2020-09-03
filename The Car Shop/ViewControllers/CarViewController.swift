//
//  CarViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 2/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit

class CarViewController: BaseViewController {
    
    var car : Car?
    @IBOutlet weak var carImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = car?.model

        carImageView.image = UIImage(named: (car?.image)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    

}
