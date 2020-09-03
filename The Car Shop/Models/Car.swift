//
//  Car.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import Foundation
import UIKit

 public class Car: Codable {
    
    var id: Int?
    var model: String?
    var seats: Int?
    var status: String?
    var price: Int?
    var dateReleased: Int?
    var category: String?
    var image: String?
    
    init(id: Int, model: String, seats: Int, status: String, price: Int, dateReleased: Int, category: String, image: String) {
        self.id = id
        self.model = model
        self.seats = seats
        self.status = status
        self.price = price
        self.dateReleased = dateReleased
        self.category = category
        self.image = image
    }
}
