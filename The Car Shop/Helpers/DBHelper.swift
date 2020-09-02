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
    
    let id = Expression<Int>("id")
    let model = Expression<String>("model")
    let seats = Expression<Int>("seats")
    let status = Expression<String>("status")
    let price = Expression<Int>("price")
    let datereleased = Expression<Int>("datereleased")
    
    init() {
        self.carShopDB = createDatabase()
        self.createTableCars()
        self.fillCarsTable()
        self.getCars()
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
        
        
        
        
        let tableToCreate = self.carsTable.create { (table) in
            table.column(id, primaryKey: true)
            table.column(model)
            table.column(seats)
            table.column(status)
            table.column(price)
            table.column(datereleased)
        }
        
        do {
            try self.carShopDB.run(tableToCreate)
            print("table created hellyeah")
        } catch {
            print(error)
        }
    }
    
    func fillCarsTable() {
        let insertCamaro = self.carsTable.insert(self.model <- "Camaro", seats <- 4, status <- "used", price <- 50000000, datereleased <- 1969)
        let insertChallenger = self.carsTable.insert(self.model <- "Challenger", seats <- 4, status <- "used", price <- 70000000, datereleased <- 1970)
        
        do {
            try carShopDB.run(insertCamaro)
            try carShopDB.run(insertChallenger)
            print("car registered")
        } catch  {
            print(error)
        }
    }
    
    func getCars() {
        do {
            let cars = try self.carShopDB.prepare(self.carsTable)
            for car in cars {
                print("this car is a \(car[self.model]), from the year \(car[self.datereleased]) and it costs \(car[self.price])")
            }
        } catch  {
            print(error)
        }
    }
    
    func update(car : Car)  {
        let carFromDb = self.carsTable.filter(self.id == car.id!)
        let carUpdate = carFromDb.update(self.model <- car.model!, seats <- car.seats!, status <- car.status!, price <- car.price!, datereleased <- car.dateReleased!)
        do {
            try self.carShopDB.run(carUpdate)
            print("model updated")
        } catch  {
            print(error)
        }
    }
}
