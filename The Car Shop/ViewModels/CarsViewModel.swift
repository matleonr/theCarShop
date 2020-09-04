//
//  CarsViewModel.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 1/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CarsViewModel: ViewModelProtocol {
    private let disposeBag = DisposeBag()
    let carsDB = DBHelper()
    struct Input {
        var screenAppeared = BehaviorRelay<Bool?>(value: false)
        var createButtonPressed = PublishSubject<Void>()
    }

    struct Output {
        var cars = BehaviorRelay<[Car]>(value: [])
        var goToCreateScreen = BehaviorRelay<Bool?>(value: false)
    }

    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()
        getCars()
        navigate()
    }

    func getCars() {
        input.screenAppeared.asObservable().subscribe(
            onNext: { screenAppeared in

                if screenAppeared! {
                    self.output.cars.accept(self.carsDB.getCars())
                }

            }).disposed(by: disposeBag)
    }
    
    func navigate() {
        input.createButtonPressed.asObserver().subscribe({ _ in
            self.output.goToCreateScreen.accept(true)
        })
    }
}
