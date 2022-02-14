//
//  ImageService.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func getImage(withName:String) -> UIImage?
    func cache(image:UIImage, withName:String)
}

class ImageService : ImageServiceProtocol {
    var imageCache : [String:UIImage]
    
    public init() {
        imageCache = [String:UIImage]()
    }
    
    func getImage(withName:String) -> UIImage? {
        var retImage : UIImage?
        if let image = imageCache[withName] {
            retImage = image
        }
        return retImage
    }
    
    func cache(image:UIImage, withName:String) {
        if let _ = imageCache[withName] {
            return
        }
        imageCache[withName] = image
    }
}
