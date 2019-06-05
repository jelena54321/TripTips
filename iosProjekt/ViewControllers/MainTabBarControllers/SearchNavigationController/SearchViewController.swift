//
//  SearchViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SearchViewController : UIViewController {
    let popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let cityCellId = "cityCellId"
    var cities: [City] = []
    let searchView = SearchView()
    let ref = Database.database().reference(withPath: "cities")
    

    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: cityCellId)
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(searchView)
        self.view.addSubview(popularCollectionView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: self.view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            popularCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            popularCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 270)])

        searchView.searchField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func textFieldDidEndEditing() {
        print("blabla")
        
        guard let cityName = searchView.searchField.text else {
            return
        }
        
        let city = cities.filter { cityElement in
            cityElement.name == cityName
        }.first
        
        if city != nil {
            let cityCategoriesViewController = CityCategoriesViewController()
            ImageService.shared.fetchImage(imageUrl: city?.image){ (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        cityCategoriesViewController.backgroundImage.image = image
                    }
                }
            }
            cityCategoriesViewController.city = city
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(cityCategoriesViewController, animated: true)
            }
        }
    }
    
    func setupView(){
        ref.observe(.value, with: { snapshot in
            var newItems: [City] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let city = City(snapshot: snapshot) {
                    newItems.append(city)
                }
            }
            self.cities = newItems
            self.searchView.searchField.setItems(items: self.cities.map{ city in
                return city.name
            })
            self.popularCollectionView.reloadData()
        })
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: cityCellId, for: indexPath) as! CityCollectionViewCell
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.2
        
        
        cell.city = cities[indexPath.row]
        ImageService.shared.fetchImage(imageUrl: cities[indexPath.row].image){ (image) in
            if image != nil {
                DispatchQueue.main.async {
                    cell.image.image = image
                }
            }
        }
        cell.nameLabel.text = cities[indexPath.row].getCityName().uppercased()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CityCollectionViewCell
        let cityCategoriesViewController = CityCategoriesViewController()
        cityCategoriesViewController.backgroundImage.image = cell.image.image
        cityCategoriesViewController.city = cell.city
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(cityCategoriesViewController, animated: true)
        }
    }

}

extension SearchViewController : UITextFieldDelegate {
    
    
}
