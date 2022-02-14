//
//  Lunch.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import CoreLocation

struct RestaurantList: Decodable {

    let restaurants: [Restaurant]

}

struct Restaurant: Decodable {
    
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location
    
}

struct Location: Decodable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let city: String
    let state: String

    let formattedAddress: [String]

}

struct Contact: Decodable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
}
