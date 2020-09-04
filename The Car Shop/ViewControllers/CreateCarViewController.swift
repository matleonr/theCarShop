//
//  CreateCarViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 4/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import RxSwift
import UIKit

class CreateCarViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var modelTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var seatsTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    let disposeBag = DisposeBag()
    let carViewModel = CreateCarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    func setUI() {
        title = "New Car"
        carImageView.image = carImageView.image?.withRenderingMode(.alwaysTemplate)
        carImageView.tintColor = .lightGray
        setPlaceholderColor()
    }
    
    func setButton() {
        saveButton.layer.cornerRadius = view.frame.height * 0.045
    }
    
    func setPlaceholderColor() {
        modelTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        yearTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        categoryTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        priceTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        seatsTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    

}
