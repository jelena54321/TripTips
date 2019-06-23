//
//  TripCreatorView.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

protocol TripCreatorDelegate {
    
    func tripCreated() -> Void
}

class TripCreatorView: UIView {
    
    private static let dateFomatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        return dateFormatter
    }()
    
    private let destinationLabel: UILabel = {
        let destinationLabel = UILabel()
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        return destinationLabel
    }()
    
    private let destinationValue: UITextField = {
        let destinationValue = UITextField()
        destinationValue.translatesAutoresizingMaskIntoConstraints = false
        return destinationValue
    }()
    
    private let departureLabel: UILabel = {
        let departureLabel = UILabel()
        departureLabel.translatesAutoresizingMaskIntoConstraints = false
        return departureLabel
    }()
    
    private let departureValue: UITextField = {
        let departureValue = UITextField()
        departureValue.translatesAutoresizingMaskIntoConstraints = false
        return departureValue
    }()
    
    private let returnLabel: UILabel = {
        let returnLabel = UILabel()
        returnLabel.translatesAutoresizingMaskIntoConstraints = false
        return returnLabel
    }()
    
    private let returnValue: UITextField = {
        let returnValue = UITextField()
        returnValue.translatesAutoresizingMaskIntoConstraints = false
        return returnValue
    }()
    
    private let createButton: UIButton = {
        let createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        return createButton
    }()
    
    private let destinationPicker: UIPickerView = {
        let destinationPicker = UIPickerView()
        destinationPicker.translatesAutoresizingMaskIntoConstraints = false
        return destinationPicker
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private var currentlyEditing: UITextField?
    
    private var destinationModel: DestinationViewModel!
    var delegate: TripCreatorDelegate?
    
    convenience init(destinationModel: DestinationViewModel) {
        self.init()
        self.destinationModel = destinationModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
        setUpPickers()
        addTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDestination() -> String? {
        return destinationModel.destination(
            forRow: destinationPicker.selectedRow(inComponent: 0)
        )
    }
    
    func getDepartureDate() -> String? {
        return departureValue.text
    }

    func getReturnDate() -> String? {
        return returnValue.text
    }
    
    @objc func createTapped() {
        delegate?.tripCreated()
    }
    
    func setBorders() {
        departureValue.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: departureValue.bounds.height - 1,
                width: departureValue.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
        
        returnValue.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: returnValue.bounds.height - 1,
                width: returnValue.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
        
        destinationValue.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: destinationValue.bounds.height - 1,
                width: destinationValue.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
    }
    
    private func setUpUI() {
        let defaultBoldFont = UIFont(name: "Montserrat-Bold", size: 20)
        let defaultThinFont = UIFont(name: "Montserrat-Thin", size: 20)
        
        destinationLabel.text = "Destination"
        destinationLabel.textAlignment = .center
        destinationLabel.font = defaultBoldFont
        
        addSubview(destinationLabel)
        NSLayoutConstraint.activate([
            destinationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            destinationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            destinationLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        destinationValue.font = defaultThinFont
        destinationValue.delegate = self
        
        addSubview(destinationValue)
        NSLayoutConstraint.activate([
            destinationValue.topAnchor.constraint(
                equalTo: destinationLabel.bottomAnchor,
                constant: 5.0
            ),
            destinationValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            destinationValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            destinationValue.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor)
        ])
        
        departureLabel.text = "Departure"
        departureLabel.font = defaultBoldFont
        departureLabel.textAlignment = .center
        
        addSubview(departureLabel)
        NSLayoutConstraint.activate([
            departureLabel.topAnchor.constraint(
                equalTo: destinationValue.bottomAnchor,
                constant: 30.0
            ),
            departureLabel.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor),
            departureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        departureValue.font = defaultThinFont
        departureValue.delegate = self
        
        addSubview(departureValue)
        NSLayoutConstraint.activate([
            departureValue.topAnchor.constraint(
                equalTo: departureLabel.bottomAnchor,
                constant: 5.0
            ),
            departureValue.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor),
            departureValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            departureValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            departureValue.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        returnLabel.text = "Return"
        returnLabel.textAlignment = .center
        returnLabel.font = defaultBoldFont
        
        addSubview(returnLabel)
        NSLayoutConstraint.activate([
            returnLabel.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor),
            returnLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            returnLabel.topAnchor.constraint(
                equalTo: departureValue.bottomAnchor,
                constant: 30.0
            )
        ])
        
        returnValue.font = defaultThinFont
        returnValue.delegate = self
        
        addSubview(returnValue)
        NSLayoutConstraint.activate([
            returnValue.topAnchor.constraint(
                equalTo: returnLabel.bottomAnchor,
                constant: 5.0
            ),
            returnValue.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor),
            returnValue.leadingAnchor.constraint(equalTo: departureValue.leadingAnchor),
            returnValue.trailingAnchor.constraint(equalTo: departureValue.trailingAnchor),
            returnValue.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        createButton.titleLabel?.font = defaultBoldFont
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(UIColor.triptipsBlue, for: .normal)
        createButton.backgroundColor = .white
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.triptipsBlue.cgColor
        createButton.layer.cornerRadius = 22.5
        
        addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(
                equalTo: returnValue.bottomAnchor,
                constant: 50.0
            ),
            createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 200.0),
            createButton.heightAnchor.constraint(equalToConstant: 40.0),
            createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setUpPickers() {
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        
        destinationPicker.dataSource = self
        destinationPicker.delegate = self
    }
    
    private func addTargets() {
        createButton.addTarget(
            self,
            action: #selector(createTapped),
            for: UIControl.Event.touchUpInside
        )
    }
}

extension TripCreatorView: UIPickerViewDelegate {}

extension TripCreatorView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return destinationModel.numberOfDestinations()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return destinationModel.destination(forRow: row)
    }
}

extension TripCreatorView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        
        let doneButton = BarItem(text: "Done")
        
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let cancelButton = BarItem(text: "Cancel")

        if textField == destinationValue {
            doneButton.addTarget(self, action: #selector(doneDestinationPicker), for: .touchUpInside)
            textField.inputView = destinationPicker
        } else {
            doneButton.addTarget(self, action: #selector(doneDatePicker), for: .touchUpInside)
            textField.inputView = datePicker
        }
        cancelButton.addTarget(self, action: #selector(cancelPicker), for: .touchUpInside)
        
        textField.inputAccessoryView = toolbar
        toolbar.items = [
            UIBarButtonItem(customView: doneButton),
            spaceButton,
            UIBarButtonItem(customView: cancelButton)
        ]
        
        currentlyEditing = textField
        toolbar.sizeToFit()
    }

    @objc func doneDatePicker() {
        currentlyEditing?.text = TripCreatorView.dateFomatter.string(from: datePicker.date)
        currentlyEditing?.textAlignment = .center
        currentlyEditing = nil
        self.endEditing(true)
    }

    @objc func doneDestinationPicker() {
        currentlyEditing?.text = getDestination()
        currentlyEditing?.textAlignment = .center
        self.endEditing(true)
    }
    
    @objc func cancelPicker() {
        currentlyEditing = nil
        self.endEditing(true)
    }
}
