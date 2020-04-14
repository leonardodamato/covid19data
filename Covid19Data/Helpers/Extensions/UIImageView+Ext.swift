//
//  UIImageView+Ext.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(imageUrl: String) {
        let cache = NetworkManager.shared.cache
        
        guard let url = URL(string: imageUrl) else { return }
        
        let cacheKey = NSString(string: imageUrl)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}
