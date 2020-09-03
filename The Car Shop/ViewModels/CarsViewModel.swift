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
        
    }
    
    struct Output{
        var isBussy = BehaviorRelay<Bool?>(value : nil)
        var alreadyLoadSuscriptions = BehaviorRelay<Bool?>(value : nil)
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
        self.output.cars.accept(carsDB.getCars())
        
    }
    
}
