//
//  CarViewController.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 2/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import RxSwift
import UIKit

class CarViewController: BaseViewController, UITextFieldDelegate {
    var car: Car?
    let disposeBag = DisposeBag()
    let carViewModel = CarViewModel()
    var enabledEdition = false

    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var carImageView: UIImageView!
    @IBOutlet var priceTextfield: UITextField!
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var numberOfSeatsTextField: UITextField!
    @IBOutlet var categoryTextfield: UITextField!
    @IBOutlet var yearTextfield: UITextField!

    @IBOutlet var editBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI(car: car!)
        bind()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func setUI(car: Car) {
        title = car.model
        carImageView.image = carImageView.image?.withRenderingMode(.alwaysTemplate)
        carImageView.tintColor = .lightGray
        carImageView.image = imageHelper.getSavedImage(named: car.image!)!

        setStatusImage(carStatus: car.status!)
        categoryTextfield.text = car.category
        priceTextfield.text = String(car.price!)
        numberOfSeatsTextField.text = String(car.seats!)
        yearTextfield.text = String(car.dateReleased!)
    }

    func setStatusImage(carStatus: String) {
        if carStatus == "new" {
            statusImageView.image = UIImage(named: "newIcon")
            statusImageView.image = statusImageView.image?.withRenderingMode(.alwaysTemplate)
            statusImageView.tintColor = UIColor(displayP3Red: 11 / 255, green: 176 / 255, blue: 26 / 255, alpha: 1)
        } else {
            statusImageView.image = UIImage(named: "usedIcon")
            statusImageView.image = statusImageView.image?.withRenderingMode(.alwaysTemplate)
            statusImageView.tintColor = UIColor(displayP3Red: 250 / 255, green: 120 / 255, blue: 24 / 255, alpha: 1)
        }
    }

    func focusKeyboard(editionEnabled: Bool) {
        if editionEnabled {
            priceTextfield.becomeFirstResponder()
        }
    }

    func setDelegate() {
        priceTextfield.delegate = self
        numberOfSeatsTextField.delegate = self
        yearTextfield.delegate = self
        categoryTextfield.delegate = self
    }

    func bind() {
        carViewModel.input.car.accept(car)
        carViewModel.output.car.asObservable().subscribe(
            onNext: { car in
                if car?.id != nil {
                    self.setUI(car: car!)
                } else {
                    // mostrar alerta de error
                }

            }).disposed(by: disposeBag)

        carViewModel.output.deletedCar.asObservable().subscribe(
            onNext: { deletedCar in
                if deletedCar! {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        )

        carViewModel.output.edititonEnabled.asObservable().subscribe(
            onNext: { editionEnabled in
                self.priceTextfield.isEnabled = editionEnabled!
                self.numberOfSeatsTextField.isEnabled = editionEnabled!
                self.categoryTextfield.isEnabled = editionEnabled!
                self.yearTextfield.isEnabled = editionEnabled!
                self.deleteButton.isHidden = !editionEnabled!
                self.saveButton.isHidden = !editionEnabled!
                self.focusKeyboard(editionEnabled: editionEnabled!)
                self.enabledEdition = editionEnabled!

            }).disposed(by: disposeBag)

        saveButton.rx.tap.asObservable().subscribe(
            onNext: {
                self.car = Car(id: (self.car?.id)!, model: (self.car?.model)!, seats: Int(self.numberOfSeatsTextField.text!)!, status: (self.car?.status)!, price: Int(self.priceTextfield.text!)!, dateReleased: Int(self.yearTextfield.text!)!, category: self.categoryTextfield.text!, image: (self.car?.image)!)
                self.carViewModel.input.car.accept(self.car)
                self.carViewModel.input.edititonEnabled.accept(self.enabledEdition)
                self.dismissKeyboard()
            }
        ).disposed(by: disposeBag)
        saveButton.rx.tap.throttle(0.5, scheduler: MainScheduler.instance).subscribe(carViewModel.input.saveButtonPressed).disposed(by: disposeBag)

        deleteButton.rx.tap.asObservable().subscribe(
            onNext: {
                self.carViewModel.input.edititonEnabled.accept(self.enabledEdition)
                self.dismissKeyboard()
            }
        ).disposed(by: disposeBag)
        deleteButton.rx.tap.throttle(0.5, scheduler: MainScheduler.instance).subscribe(carViewModel.input.deleteButtonPressed).disposed(by: disposeBag)

        editBarButton.rx.tap.asObservable().subscribe(
            onNext: {
                self.carViewModel.input.edititonEnabled.accept(self.enabledEdition)
                self.dismissKeyboard()
            }
        ).disposed(by: disposeBag)
    }
}
