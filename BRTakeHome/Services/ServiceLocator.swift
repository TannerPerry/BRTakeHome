//
//  ServiceLocator.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation

class ServiceLocator {
    
    public static let shared = ServiceLocator()
    
    fileprivate var _lunchService : LunchServiceProtocol
    fileprivate var _imageService : ImageServiceProtocol
    
    private init() {
        _imageService = ImageService()
        _lunchService = LunchService(imageService: _imageService)
        
    }
    
    var lunchService : LunchServiceProtocol {
        return _lunchService
    }
}
