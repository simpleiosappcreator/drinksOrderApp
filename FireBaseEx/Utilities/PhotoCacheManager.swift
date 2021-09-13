//
//  photoCacheManager.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
import SwiftUI

class PhotoCacheManager{
    static var instance = PhotoCacheManager()
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * cache.countLimit
        return cache
    }()
    
    func save(key: String, value: UIImage){
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage?{
        return imageCache.object(forKey: key as NSString)
    }
    
}
