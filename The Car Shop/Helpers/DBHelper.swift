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
    let imageHelper = ImageHelper()

    let id = Expression<Int>("id")
    let model = Expression<String>("model")
    let seats = Expression<Int>("seats")
    let status = Expression<String>("status")
    let price = Expression<Int>("price")
    let datereleased = Expression<Int>("datereleased")
    let category = Expression<String>("category")
    let image = Expression<String>("image")

    init() {
        carShopDB = createDatabase()
        createTableCars()
        fillCarsTable()
    }

    func createDatabase() -> Connection! {
        do {
            let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathExtension(path)

            let db = try Connection(filepath.path)
            print("database created with path \(filepath.path)")
            return db
        } catch {
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
            table.column(image)
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
            for carToFill in generateCarsToFill() {
                let carToInsert = carsTable.insert(model <- carToFill.model!, seats <- carToFill.seats!, status <- carToFill.status!, price <- carToFill.price!, datereleased <- carToFill.dateReleased!, category <- carToFill.category!, image <- carToFill.image!)
                do {
                    try carShopDB.run(carToInsert)

                    print("car registered successfully")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func saveImages() -> [String] {
        var paths : [String] = []
        paths.append(imageHelper.saveImage(image: UIImage(named:"Camaro Image")!, nameImage: "Camaro_Image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Challenger image")!, nameImage: "Challenger_image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Mustang Image")!, nameImage: "Mustang_Image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Twizy image")!, nameImage: "Twizy_image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Tesla Model 3 image")!, nameImage: "Tesla_Model_3_image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Ssangyong Tivoli image")!, nameImage: "Ssangyong_Tivoli_image"))
        paths.append(imageHelper.saveImage(image: UIImage(named:"Renault Twingo image")!, nameImage: "Renault_Twingo_image"))
        return paths
    }

    func generateCarsToFill() -> [Car] {
        var carsToFill: [Car] = []

        let car1 = Car(id: 1, model: "Chevrolet Camaro", seats: 4, status: "used", price: 36500, dateReleased: 1969, category: "commercial", image: saveImages()[0])
        let car2 = Car(id: 2, model: "Dogde Challenger", seats: 4, status: "used", price: 15000, dateReleased: 1970, category: "commercial", image: saveImages()[1])
        let car3 = Car(id: 3, model: "Ford Mustang", seats: 4, status: "used", price: 34900, dateReleased: 1964, category: "commercial", image: saveImages()[2])
        let car4 = Car(id: 4, model: "Renault Twizy", seats: 2, status: "new", price: 8886, dateReleased: 2011, category: "electric", image: saveImages()[3])
        let car5 = Car(id: 5, model: "Tesla Model 3", seats: 5, status: "new", price: 59088, dateReleased: 2016, category: "electric", image: saveImages()[4])
        let car6 = Car(id: 6, model: "Ssangyong Tivoli", seats: 5, status: "new", price: 7510, dateReleased: 2014, category: "truck", image: saveImages()[5])
        let car7 = Car(id: 7, model: "Renault Twingo", seats: 4, status: "used", price: 5739, dateReleased: 1993, category: "commercial", image: saveImages()[6] )

        carsToFill.append(car1)
        carsToFill.append(car2)
        carsToFill.append(car3)
        carsToFill.append(car4)
        carsToFill.append(car5)
        carsToFill.append(car6)
        carsToFill.append(car7)

        return carsToFill
    }
    
    func create(car: Car) {
        let carToInsert = carsTable.insert(model <- car.model!, seats <- car.seats!, status <- car.status!, price <- car.price!, datereleased <- car.dateReleased!, category <- car.category!, image <- car.image!)
        do {
            try carShopDB.run(carToInsert)

            print("car registered successfully")
        } catch {
            print(error)
        }
    }

    func getCars() -> [Car] {
        var carsArray = [Car]()

        do {
            let cars = try carShopDB.prepare(carsTable)

            for car in cars {
                print("this car is a \(car[model]), from the year \(car[datereleased]) and it costs \(car[price])")

                let carScoped = Car(id: car[id], model: car[model], seats: car[seats], status: car[status], price: car[price], dateReleased: car[datereleased], category: car[category], image: car[image])

                carsArray.append(carScoped)
            }
            return carsArray
        } catch {
            print(error)
            return carsArray
        }
    }

    func getCar(CarId: Int) -> Car? {
        let carFromDb = carsTable.filter(id == CarId)
        var car: Car?
        do {
            for carGetted in try carShopDB.prepare(carFromDb) {
                car = Car(id: carGetted[id], model: carGetted[model], seats: carGetted[seats], status: carGetted[status], price: carGetted[price], dateReleased: carGetted[datereleased], category: carGetted[category], image: carGetted[image])
                return car
            }

        } catch {
            print(error)
        }
        return car
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
        let carFromDb = carsTable.filter(id == car.id!)
        let carDelete = carFromDb.delete()
        do {
            try carShopDB.run(carDelete)
        } catch {
            print(error)
        }
    }
}
