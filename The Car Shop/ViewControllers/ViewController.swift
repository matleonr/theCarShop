//
//  ViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 31/08/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: BaseViewController {
    var cars: [Car] = []
    let disposeBag = DisposeBag()
    let carsViewModel = CarsViewModel()

    @IBOutlet weak var createBarButton: UIBarButtonItem!
    @IBOutlet var carsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUI()
        carsTableView.delegate = self
        carsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carsViewModel.input.screenAppeared.accept(true)
    }

    func updateTable() {
        let indexPath = IndexPath(row: cars.count - 1, section: 0)

        carsTableView.beginUpdates()
        carsTableView.insertRows(at: [indexPath], with: .automatic)
        carsTableView.endUpdates()
    }

    func cleanTable() {
        carsTableView.endUpdates()
        cars.removeAll()
        carsTableView.reloadData()
    }

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
                self.cleanTable()
                for car in carsRecieved {
                    self.cars.append(car)
                    self.updateTable()
                }

            }).disposed(by: disposeBag)
        
        createBarButton.rx.tap.throttle(0.5, scheduler: MainScheduler.instance).subscribe(carsViewModel.input.createButtonPressed).disposed(by: disposeBag)
        
        
        carsViewModel.output.goToCreateScreen.asObservable().subscribe(
            onNext: { goToCreate in
                if goToCreate! {
                    //go to create
                    self.performSegue(withIdentifier: "CreateCar", sender: nil)
                }
            }
        ).disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
