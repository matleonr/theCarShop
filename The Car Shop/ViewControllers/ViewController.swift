//
//  ViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 31/08/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: BaseViewController {

    var cars : [Car] = []
    let disposeBag = DisposeBag()
    let carsViewModel = CarsViewModel()
    
    @IBOutlet weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        loadCars()
        setUI()
        carsTableView.delegate = self
        carsTableView.dataSource = self
    }
    
    func loadCars() {
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
            let carVC = segue.destination as! CarViewController
            carVC.car = sender as? Car
        }
    }
    
    func setUI() {
        title = "The Car Shop"
        carsTableView.layer.cornerRadius = 20
    }
    
    
    func bind() {

        carsViewModel.output.cars.asObservable().subscribe(
            onNext: { carsRecieved in
                
                for car in carsRecieved {
                    self.cars.append(car)
                }
                
        }).disposed(by: disposeBag)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = cars[indexPath.row]
        performSegue(withIdentifier: "MasterToDetail", sender: car)
    }
        
    
}

