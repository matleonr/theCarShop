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
    
    func set (car:Car) {
        priceLabel.text = String(describing: car.price)
        statusLabel.text = car.status
        modelLabel.text = car.model
        categoryLabel.text = car.category
    }

}
