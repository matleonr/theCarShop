//
//  DBHelper.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//
import SQLite
import Foundation

class DBHelper {
    
    var carShopDB : OpaquePointer?
    var path : String = "carShop.sqlite"
    
    init() {
        
    }
    
    func createDatabase() -> OpaquePointer? {
        <#function body#>
    }
}
