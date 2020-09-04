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
        
    }

    struct Output {
        
    }
    
    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()
//        getCars()
//        navigate()
    }
}
