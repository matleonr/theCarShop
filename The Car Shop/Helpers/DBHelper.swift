//
import Foundation
//  DBHelper.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//
import SQLite

class DBHelper {
    var carShopDB: Connection!
    var path: String = "carShop.sqlite3"
    let carsTable = Table("cars")

    let id = Expression<Int>("id")
    let model = Expression<String>("model")
    let seats = Expression<Int>("seats")
    let status = Expression<String>("status")
    let price = Expression<Int>("price")
    let datereleased = Expression<Int>("datereleased")
    let category = Expression<String>("category")

    init() {
        carShopDB = createDatabase()
        createTableCars()
        fillCarsTable()
    }

    func createDatabase() -> Connection! {
        do {
            let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathExtension(path)

            let db = try Connection(filepath.path)
            return db
            print("database created with path \(path)")

        } catch {
            print("damn")
            print(error)
            return nil
        }
    }

    func createTableCars() {
        let tableToCreate = carsTable.create { table in
            table.column(id, primaryKey: true)
            table.column(model)
            table.column(seats)
            table.column(status)
            table.column(price)
            table.column(datereleased)
            table.column(category)
        }

        do {
            try carShopDB.run(tableToCreate)
            print("table created hellyeah")
        } catch {
            print(error)
        }
    }

    func fillCarsTable() {
        if getCars().count == 0 {
            let insertCamaro = carsTable.insert(model <- "Camaro", seats <- 4, status <- "used", price <- 50000000, datereleased <- 1969, category <- "commercial")
            let insertChallenger = carsTable.insert(model <- "Challenger", seats <- 4, status <- "used", price <- 70000000, datereleased <- 1970, category <- "commercial")

            do {
                try carShopDB.run(insertCamaro)

                print("camaro registered")
            } catch {
                print(error)
            }

            do {
                try carShopDB.run(insertChallenger)
                print("challenger registered")
            } catch {
                print(error)
            }
        }
    }

    func getCars() -> [Car] {
        var carsArray = [Car]()

        do {
            let cars = try carShopDB.prepare(carsTable)

            for car in cars {
                print("this car is a \(car[model]), from the year \(car[datereleased]) and it costs \(car[price])")

                let carScoped = Car(id: car[id], model: car[model], seats: car[seats], status: car[status], price: car[price], dateReleased: car[datereleased], category: car[category])

                carsArray.append(carScoped)
            }
            return carsArray
        } catch {
            print(error)
            return carsArray
        }
    }

    func update(car: Car) {
        let carFromDb = carsTable.filter(id == car.id!)
        let carUpdate = carFromDb.update(model <- car.model!, seats <- car.seats!, status <- car.status!, price <- car.price!, datereleased <- car.dateReleased!, category <- car.category!)
        do {
            try carShopDB.run(carUpdate)
            print("model updated")
        } catch {
            print(error)
        }
    }

    func delete(car: Car) {
    }
}
