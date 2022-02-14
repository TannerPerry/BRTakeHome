//
//  MapDetailViewPresenter.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/14/22.
//

import Foundation


class RestaurantDetailViewPresenter {
    
    var detailView : RestaurantDetailViewProtocol
    var restaurant : Restaurant
    
    public init(detailView: RestaurantDetailViewProtocol, restaurant:Restaurant) {
        self.detailView = detailView
        self.restaurant = restaurant
        
        setupRestaurantDetail()
        setupMap()
    }
    
    func setupRestaurantDetail() {
        let detailModel = RestaurantDetailModel(name: restaurant.name, category: restaurant.category, formattedPhoneNumber: restaurant.contact?.formattedPhone, twitterHandle: restaurant.contact?.twitter, address: restaurant.location.address, city: restaurant.location.city, state: restaurant.location.state)
        detailView.updateDetailView(restaurantDetailModel: detailModel)
    }
    
    func setupMap() {
        let annotaion = MapAnnotationModel(latitude: restaurant.location.lat, longitude: restaurant.location.lng, name: restaurant.name)
        detailView.annotateMap(mapAnnotation: annotaion)
    }
    
    func phoneNumberTapped() {
        guard let phoneNumber = restaurant.contact?.phone else { return }
        
        if let phoneNumberURL = URL(string: "tel://\(phoneNumber)") {
            detailView.makeCall(phoneNumberURL: phoneNumberURL)
        }
    }
    
    func mapSelected() {
        detailView.navigateToMapView()
    }
}
