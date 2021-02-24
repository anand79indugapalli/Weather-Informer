//
//  ImageDownloader.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 24/02/21.
//

import UIKit

private var imageCache: [String: UIImage] = [:]


extension UIImageView {
    func loadImageFrom(url: String?, placeholder: UIImage? = nil) {
        guard let urlString = url, let finalUrl = URL(string: urlString) else {
            if placeholder != nil {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
            return
        }
        loadImageFrom(url: finalUrl, placeholder: placeholder)
    }
    
    func loadImageFrom(url: URL, placeholder: UIImage? = nil) {
        
        if let cacheImage = imageCache[url.absoluteString] {
            DispatchQueue.main.async {
                self.image = cacheImage
            }
            return
        }
        
        func setPlaceholder() {
            if placeholder != nil {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }
        
        setPlaceholder()
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data, let img = UIImage(data: data) {
                imageCache[url.absoluteString] = img
                
                DispatchQueue.main.async {
                    self.image = img
                }
            } else {
                setPlaceholder()
            }
            
        }).resume()
        
    }
}
