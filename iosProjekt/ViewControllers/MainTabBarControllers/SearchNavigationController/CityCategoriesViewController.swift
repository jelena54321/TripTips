//
//  CityCategoriesViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CityCategoriesViewController : UIViewController {
    
    let categories = ["cafes", "restaurants", "museums", "sights"]
    let backButton = UIButton()
    let backgroundImage = UIImageView()
    let countryLabel = UILabel()
    let countryBackground = UIView()
    let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    let blurEffectView = UIVisualEffectView()
    var backgroundImageTopConstraint : NSLayoutConstraint? = nil
    var backgroundImageBottomConstraint : NSLayoutConstraint? = nil
    let cellId = "cellId"
    var city : City? = nil
    

    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(CategoryMenuCell.self, forCellWithReuseIdentifier: cellId)
                
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView(){
        self.navigationItem.hidesBackButton = true
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(blurEffectView)
        self.view.addSubview(backButton)
        self.view.addSubview(menuCollectionView)
        self.view.addSubview(countryBackground)
        self.view.addSubview(countryLabel)
        
        blurEffectView.effect = UIBlurEffect(style: .regular)
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.masksToBounds = true
        
        countryBackground.backgroundColor = UIColor.triptipsYellow
        countryBackground.layer.cornerRadius = 15
        countryBackground.layer.masksToBounds = false
        countryBackground.clipsToBounds = false
        countryBackground.layer.shadowColor = UIColor.black.cgColor
        countryBackground.layer.shadowRadius = 5
        countryBackground.layer.shadowOpacity = 0.3
        countryBackground.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        countryLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        countryLabel.text = self.city?.getCountryName()
        countryLabel.textColor = .black

        
        
        backgroundImageTopConstraint = backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        backgroundImageBottomConstraint = backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowRadius = 5
        backButton.layer.shadowOpacity = 0.3
        backButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.layer.masksToBounds = false
        backButton.clipsToBounds = false
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageTopConstraint!,
            backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 45)])
        
        countryBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryBackground.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            countryBackground.heightAnchor.constraint(equalToConstant: 30),
            countryBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            countryBackground.widthAnchor.constraint(equalTo: countryLabel.widthAnchor, multiplier: 1.6)])
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryLabel.centerYAnchor.constraint(equalTo: countryBackground.centerYAnchor),
            countryLabel.centerXAnchor.constraint(equalTo: countryBackground.centerXAnchor)
            ])
        
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75),
            menuCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        menuCollectionView.clipsToBounds = false
        menuCollectionView.layer.masksToBounds = false
        
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
    }
    
    @objc
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func categoryButtonTap(_ sender : CustomImageButton){
        let toDoTableViewController = ToDoTableViewController()
        toDoTableViewController.category = sender.refName
        toDoTableViewController.city = city?.name
        toDoTableViewController.cityName = city?.getCityName()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(toDoTableViewController, animated: true)
        }
    }
}

extension CityCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryMenuCell

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.2
        
        guard let city = city else {
            return cell
        }
        cell.descriptionLabel.text = city.description
        cell.nameLabel.text = city.getCityName()
        
        cell.stackViewLeft.arrangedSubviews.forEach{ view in
            guard let button = view as? UIButton else{
                return
            }
            button.addTarget(self, action: #selector(categoryButtonTap), for: .touchUpInside)
        }
        cell.stackViewRight.arrangedSubviews.forEach{ view in
            guard let button = view as? UIButton else{
                return
            }
            button.addTarget(self, action: #selector(categoryButtonTap), for: .touchUpInside)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height = self.view.frame.height-75
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top = self.view.frame.height - 230
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scaleFactor = abs(scrollView.contentOffset.y) * 0.3
        self.blurEffectView.alpha = scrollView.contentOffset.y * 0.003
        self.countryLabel.alpha = 1.3-scrollView.contentOffset.y * 0.005
        self.countryBackground.alpha = 1.3-scrollView.contentOffset.y * 0.005 
        self.backgroundImageBottomConstraint?.constant = scaleFactor
        self.backgroundImageTopConstraint?.constant = -scaleFactor
    }
}

