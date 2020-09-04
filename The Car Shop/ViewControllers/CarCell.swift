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
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    
    func set (car:Car) {
        priceLabel.text = "$\(String(describing: car.price!))"
        setStatusImage(carStatus: car.status!)
        modelLabel.text = car.model
        categoryLabel.text = car.category
        carPicture.image = UIImage(named: car.image!)
    }
    
    
    func setStatusImage(carStatus:String) {
        if carStatus == "new" {
            statusImage.image = UIImage(named: "newIcon")
            statusImage.image = statusImage.image?.withRenderingMode(.alwaysTemplate)
            statusImage.tintColor = UIColor(displayP3Red: 11/255, green: 176/255, blue: 26/255, alpha: 1)
        }else {
           statusImage.image = UIImage(named: "usedIcon")
            statusImage.image = statusImage.image?.withRenderingMode(.alwaysTemplate)
            statusImage.tintColor = UIColor(displayP3Red: 250/255, green: 120/255, blue: 24/255, alpha: 1)
        }
        
    }


}
