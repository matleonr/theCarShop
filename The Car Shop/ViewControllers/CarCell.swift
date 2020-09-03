//
//  CarCell.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var carPicture: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    func set (car:Car) {
        priceLabel.text = "$\(String(describing: car.price!))"
        setStatusLabel(carStatus: car.status!)
        modelLabel.text = car.model
        categoryLabel.text = car.category
        carPicture.image = UIImage(named: car.image!)
    }
    
    func setStatusLabel(carStatus:String) {
        statusView.layer.cornerRadius = statusView.frame.height * 0.5
        statusView.layer.borderWidth = 2
        statusView.layer.borderColor = setStatusColor(carStatus: carStatus)
        statusLabel.text = carStatus
        statusLabel.textColor = setLabelColor(carStatus: carStatus)
    }
    
    func setStatusColor(carStatus:String) -> CGColor{
        if carStatus == "new" {
            return .init(srgbRed: 250/255, green: 120/255, blue: 24/255, alpha: 1)
        }else {
            return .init(srgbRed: 11/255, green: 176/255, blue: 26/255, alpha: 1)
        }
    }
    
    func setLabelColor(carStatus:String) -> UIColor {
        if carStatus == "new" {
            return UIColor(displayP3Red: 250/255, green: 120/255, blue: 24/255, alpha: 1)
        }else{
            return UIColor(displayP3Red: 11/255, green: 176/255, blue: 26/255, alpha: 1)
        }
    }

}
