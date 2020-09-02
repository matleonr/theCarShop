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
    
    var carShopDB : Connection!
    var path : String = "carShop.sqlite3"
    let carsTable = Table("cars")
    
    init() {
        self.carShopDB = createDatabase()
        self.createTableCars()
    }
    
    func createDatabase() -> Connection! {
        
        do{
            let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathExtension(path)
        
            let db = try Connection(filepath.path)
            return db
            print("database created with path \(path)")

        }catch{
            
            print("damn")
            print(error)
            return nil
        }
    }
    
    func createTableCars() {
        
        let id = Expression<Int>("id")
        let model = Expression<String>("model")
        let seats = Expression<Int>("seats")
        let status = Expression<String>("status")
        let price = Expression<Int>("price")
        let datereleased = Expression<Int>("datereleased")
        
        
        let createdTable = self.carsTable.create { (table) in
            table.column(id, primaryKey: true)
            table.column(model)
            table.column(seats)
            table.column(status)
            table.column(price)
            table.column(datereleased)
        }
        
        do {
            try self.carShopDB.run(createdTable)
            print("table created hellyeah")
        } catch {
            print(error)
        }
    }
    
    
}
