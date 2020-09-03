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

public class CarViewModel:ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    let carsDB = DBHelper()
    public struct Input{
        
    }
    
    public struct Output{
        var isBussy = BehaviorRelay<Bool?>(value : nil)
        var alreadyLoadSuscriptions = BehaviorRelay<Bool?>(value : nil)
    }
    
    let input : Input
    let output : Output
    
    init(){
        input = Input()
        output = Output()
        
    }
}
