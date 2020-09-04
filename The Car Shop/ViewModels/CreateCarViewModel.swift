//
//  CreateCarViewModel.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 4/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CreateCarViewModel: ViewModelProtocol {
    private let disposeBag = DisposeBag()
    let carsDB = DBHelper()
    
    struct Input {
        var saveButtonPressed = PublishSubject<Void>()
        var car = BehaviorRelay<Car?>(value: nil)
    }

    struct Output {
        
    }
    
    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()
        create()
    }
    
    func create() {
        input.saveButtonPressed.asObserver().subscribe({ _ in

            if self.input.car.value?.model != nil {
                self.carsDB.create(car: self.input.car.value!)
            }
        }).disposed(by: disposeBag)
    }
}
