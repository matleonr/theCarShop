//
//  ViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 31/08/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    let carsDB = DBHelper()
    var cars : [Car] = []
    
    @IBOutlet weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "The Car Shop"
        cars = carsDB.getCars()
        carsTableView.delegate = self
        carsTableView.dataSource = self
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = cars[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell") as! CarCell
        cell.set(car: car)
        return cell
    }
    
    
}

