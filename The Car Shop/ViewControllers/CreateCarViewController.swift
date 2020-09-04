//
//  CreateCarViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 4/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import RxSwift
import UIKit

class CreateCarViewController: BaseViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var modelTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var seatsTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func addPhotoBarButton(_ sender: Any) {
       let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true) {
            
        }
    }
    @IBOutlet weak var SwichNew: UISwitch!
    
    //let imageHelper = ImageHelper()
    let disposeBag = DisposeBag()
    let createCarViewModel = CreateCarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        let tapHidekeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapHidekeyboard)
        
    }
    
    
    func readSwitch(status:UISwitch) -> String {
        if status.isOn{
            return "new"
        }else {
            return "used"
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            carImageView.image = image
        }else{
            //mostrar alerta de error
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI() {
        title = "New Car"
        carImageView.image = carImageView.image?.withRenderingMode(.alwaysTemplate)
        carImageView.tintColor = .lightGray
        
        setPlaceholderColor()
        setButton()
    }
    
    func setButton() {
        saveButton.layer.cornerRadius = (view.frame.height * 0.045)/2
    }
    
    func setPlaceholderColor() {
        modelTextfield.attributedPlaceholder = NSAttributedString(string: "Model",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        yearTextfield.attributedPlaceholder = NSAttributedString(string: "Year",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        categoryTextfield.attributedPlaceholder = NSAttributedString(string: "Category",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        priceTextfield.attributedPlaceholder = NSAttributedString(string: "Price",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        seatsTextfield.attributedPlaceholder = NSAttributedString(string: "Seats",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    func createNewCar() -> Car {
        let car = Car(id: 0, model: self.modelTextfield.text ?? "not Defined", seats: Int(self.seatsTextfield.text ?? "0")!, status: readSwitch(status: SwichNew), price: Int(priceTextfield.text ?? "0")!, dateReleased: Int(yearTextfield.text ?? "0")!, category: categoryTextfield.text ?? "commercial", image: imageHelper.saveImage(image: self.carImageView.image!, nameImage: "\(self.modelTextfield.text) -\(self.date)"))
        return car
    }
    
    func bind() {
        saveButton.rx.tap.asObservable().subscribe(
            onNext: {
                
                self.createCarViewModel.input.car.accept(self.createNewCar())
                
                
        }).disposed(by: disposeBag)
        
        saveButton.rx.tap.throttle(0.5, scheduler: MainScheduler.instance).subscribe(createCarViewModel.input.saveButtonPressed).disposed(by: disposeBag)
    }
    

}
