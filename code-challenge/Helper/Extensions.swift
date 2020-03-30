//
//  Extensions.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    func loadImage(imageString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlSting = imageString, let url = URL(string: urlSting) else { return }
        completion(nil)
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject), let setImage = imageFromCache as? UIImage  {
            completion(setImage)
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data,response,error) in
            if let responseData = data {
                guard let imageToCache = UIImage(data: responseData) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                DispatchQueue.main.async {
                    completion(imageToCache)
                }
                
            } else {
                completion(nil)
            }
        }.resume()
    }
}

// MARK: - Date extension
extension Date {
    
    /// formattedDateString function is to format date in Australia/Sydney time zone
    /// and it return as a string
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_AU")
        dateFormatter.timeZone = TimeZone(abbreviation: "Australia/Sydney")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
}
