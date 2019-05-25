//
//  ImageService.swift
//  iosProjekt
//
//  Created by five on 23/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    static let shared = ImageService()

    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func fetchImage(imageUrl: String?, completion: @escaping ((UIImage?) -> Void)){
        
        if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }
        
        guard let imageUrlString = imageUrl else {
            completion(nil)
            return
        }
        if let url = URL(string: imageUrlString) {
            
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}

