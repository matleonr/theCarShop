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

class CarsViewModel:ViewModelProtocol{
    
    private let disposeBag = DisposeBag()
    let carsDB = DBHelper()
    struct Input{
        var screenAppeared = BehaviorRelay<Bool?>(value : false)
    }
    
    struct Output{
        var cars = BehaviorRelay<[Car]>(value : [])
    }
    
    let input : Input
    let output : Output
    
    init(){
        input = Input()
        output = Output()
        getCars()
    }
    
    func getCars() {
        input.screenAppeared.asObservable().subscribe(
            onNext: { screenAppeared in
            
                if screenAppeared!{
                    self.output.cars.accept(self.carsDB.getCars())
                }
            
            }).disposed(by: disposeBag)
    }
    
    
    
}
