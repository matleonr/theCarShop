//
//  CarViewModel.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 3/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public class CarViewModel: ViewModelProtocol {
    private let disposeBag = DisposeBag()
    let carsDB = DBHelper()
    public struct Input {
        var idCar = BehaviorRelay<Int?>(value: nil)
        var car = BehaviorRelay<Car?>(value: nil)
        var saveButtonPressed = PublishSubject<Void>()
        var deleteButtonPressed = PublishSubject<Void>()
        var editButtonPressed = PublishSubject<Void>()
        var edititonEnabled = BehaviorRelay<Bool?>(value: true)
    }

    public struct Output {
        var car = BehaviorRelay<Car?>(value: nil)
        var edititonEnabled = BehaviorRelay<Bool?>(value: false)
        var deletedCar = BehaviorRelay<Bool?>(value: false)
    }

    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()
        update()
        delete()
        edit()
    }

    func update() {
        input.saveButtonPressed.asObserver().subscribe({ _ in

            self.carsDB.update(car: self.input.car.value!)
            self.output.car.accept(self.carsDB.getCar(CarId: (self.input.car.value?.id)!))
        }).disposed(by: disposeBag)
    }

    func delete() {
        input.deleteButtonPressed.asObserver().subscribe({ _ in
            self.carsDB.delete(car: self.input.car.value!)
            self.output.deletedCar.accept(true)
        }).disposed(by: disposeBag)
    }

    func edit() {
        input.edititonEnabled.asObservable().subscribe({ _ in
            if self.input.car.value?.category == "electric" {
                self.output.edititonEnabled.accept(false)
            } else {
                self.output.edititonEnabled.accept(!self.input.edititonEnabled.value!)
            }

        }).disposed(by: disposeBag)
    }
}
