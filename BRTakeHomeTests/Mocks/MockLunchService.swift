//
//  MockLunchService.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import UIKit
@testable import BRTakeHome

class MockLunchService : LunchServiceProtocol {
    
    var fetchRestaurantsCalled = false
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], WSError>) -> Void) {
        fetchRestaurantsCalled = true
        completion(.success([createRestuarant()]))
        return
    }
    
    var fetchRestaurantImageCalled = false
    var fetchRestaurantImagePassedRestaurant : Restaurant?
    func fetchRestaurantImage(restaurant: Restaurant, completion: @escaping (Result<UIImage, WSError>) -> Void) {
        fetchRestaurantImageCalled = true
        fetchRestaurantImagePassedRestaurant = restaurant
        completion(.success(UIImage()))
    }
    
    
    private func createRestuarant() -> Restaurant {
        let contact = Contact(phone: "phone", formattedPhone: "formattedPhone", twitter: "twitter")
        let location = Location(address: "address", crossStreet: "crossStreet", lat: 100.00, lng: 100.00, postalCode: "postalCode", city: "city", state: "state", formattedAddress: ["addr1", "addr2"])
        return Restaurant(name: "Name", backgroundImageURL: "imageUrl", category: "category", contact: contact, location: location)
    }
}
