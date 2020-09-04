//
//  CarViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 2/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit
import RxSwift

class CarViewController: BaseViewController {
    
    var car : Car?
    let disposeBag = DisposeBag()
    let carsViewModel = CarsViewModel()
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var numberOfSeatsTextField: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(car:car!)
    }
    
  
    
    
    func setUI(car:Car) {
        title = car.model

        carImageView.image = UIImage(named: (car.image)!)
        
        setStatusImage(carStatus: car.status!)
        categoryTextfield.text = car.category
        priceLabel.text = String(car.price!)
        numberOfSeatsTextField.text = String(car.seats!)
        yearTextfield.text = String(car.dateReleased!)

    }
    
    func setStatusImage(carStatus:String) {
        if carStatus == "new" {
            statusImageView.image = UIImage(named: "newIcon")
            statusImageView.image = statusImageView.image?.withRenderingMode(.alwaysTemplate)
            statusImageView.tintColor = UIColor(displayP3Red: 11/255, green: 176/255, blue: 26/255, alpha: 1)
        }else {
           statusImageView.image = UIImage(named: "usedIcon")
            statusImageView.image = statusImageView.image?.withRenderingMode(.alwaysTemplate)
            statusImageView.tintColor = UIColor(displayP3Red: 250/255, green: 120/255, blue: 24/255, alpha: 1)
        }
        
    }
    
    
    func bind() {
        
    }

}
