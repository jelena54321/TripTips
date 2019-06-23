//
//  SetUpController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class SetUpController: UIViewController {
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        return submitButton
    }()
    
    private let returnButton: UIButton = {
        let returnButton = BackButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        return returnButton
    }()
    
    private var centerYConstraint: NSLayoutConstraint!
    private var fieldViewModel: FieldViewModel!
    
    convenience init(fieldViewModel: FieldViewModel) {
        self.init()
        self.fieldViewModel = fieldViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addTargets()
        addKeyboardObservers()
    }
    
    @objc func submitChange() {
        guard let newValue = textField.text else {
            return
        }
        
        fieldViewModel.updateField(newValue: newValue) { [weak self]
            (updateStatus) in
            if self == nil { return }
            
            let alert: UIAlertController
            if updateStatus == UpdateStatus.SUCCESS {
                alert = UIAlertController(
                    title: "Success",
                    message: String(
                        format: "%@ modification was successful",
                        self!.fieldViewModel.getField()
                    ),
                    preferredStyle: .alert
                )
            } else {
                alert = UIAlertController(
                    title: "Failure",
                    message: String(
                        format: "%@ modification was unsuccessful",
                        self!.fieldViewModel.getField()
                    ),
                    preferredStyle: .alert
                )
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func returnButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
                
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            returnButton.widthAnchor.constraint(equalToConstant: 60.0),
            returnButton.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        view.addSubview(viewsContainer)
        NSLayoutConstraint.activate([
            viewsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            viewsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0)
        ])
        
        centerYConstraint = viewsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYConstraint.isActive = true
        
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 35)
        titleLabel.text = String(
            format: "Change your\n%@",
            fieldViewModel.getField()
        )
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        viewsContainer.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewsContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor)
        ])
        
        textField.delegate = self
        textField.font = UIFont(name: "Montserrat-Thin", size: 20)
        textField.textColor = .darkGray
        textField.autocapitalizationType = .none
        textField.text = String(
            format: "Enter new %@ here...",
            fieldViewModel.getField()
        )
        
        viewsContainer.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60.0),
            textField.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.triptipsBlue, for: .normal)
        submitButton.backgroundColor = .white
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.triptipsBlue.cgColor
        submitButton.layer.cornerRadius = 22.5
        
        viewsContainer.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 45.0),
            submitButton.widthAnchor.constraint(equalToConstant: 200.0),
            submitButton.heightAnchor.constraint(equalToConstant: 40.0),
            submitButton.bottomAnchor.constraint(equalTo: viewsContainer.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: viewsContainer.centerXAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        textField.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: textField.bounds.height - 1,
                width: textField.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
    }
    
    private func addTargets() {
        submitButton.addTarget(
            self,
            action: #selector(submitChange),
            for: UIControl.Event.touchUpInside
        )
        
        returnButton.addTarget(
            self,
            action: #selector(returnButtonTapped),
            for: UIControl.Event.touchUpInside
        )
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            centerYConstraint.constant = -keyboardHeight / 3.0
            UIView.animate(withDuration: 0.5) { [weak self] () in
                self?.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        centerYConstraint.constant = 0.0
        UIView.animate(withDuration: 0.5) { [weak self] () in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            return keyboardFrame.cgRectValue.height
        }
        
        return nil
    }
}

extension SetUpController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.isSecureTextEntry = fieldViewModel.isSecured()
        textField.text = ""
        return true
    }
    
}
