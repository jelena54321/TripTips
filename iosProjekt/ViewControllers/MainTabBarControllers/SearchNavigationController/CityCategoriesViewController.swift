//
//  CityCategoriesViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class CityCategoriesViewController : UIViewController {
    let backgroundImage = UIImageView()
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
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(blurEffectView)
        self.view.addSubview(menuCollectionView)
        
        blurEffectView.effect = UIBlurEffect(style: .regular)
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.masksToBounds = true
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            menuCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        menuCollectionView.clipsToBounds = false
        menuCollectionView.layer.masksToBounds = false
    }
    
    func setupView(){

    }
    
    @objc
    func categoryButtonTap(){
        
        let toDoTableViewController = ToDoTableViewController()
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
        let height = self.view.frame.height-60
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top = self.view.frame.height - 230
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scaleFactor = 1 + abs(scrollView.contentOffset.y) * 0.003
        self.blurEffectView.alpha = abs(scrollView.contentOffset.y) * 0.003
        self.backgroundImage.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }
}

