//
//  MockRestaurantDetailView.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/14/22.
//

import Foundation
@testable import BRTakeHome

class MockRestaurantDetailView : RestaurantDetailViewProtocol {
    
    var navigateToMapViewCalled = false
    func navigateToMapView() {
        navigateToMapViewCalled = true
    }
    
    
    var makeCallCalled = false
    var makeCallPassedURL : URL?
    func makeCall(phoneNumberURL: URL) {
        makeCallCalled = true
        makeCallPassedURL = phoneNumberURL
    }
    
    var annotateMapCalled = false
    var annotateMapPassedMapAnnotation: MapAnnotationModel?
    func annotateMap(mapAnnotation: MapAnnotationModel) {
        annotateMapCalled = true
        annotateMapPassedMapAnnotation = mapAnnotation
    }
    
    var updateDetailViewCalled = false
    var updateDetailViewPassedRestaurantDetail : RestaurantDetailModel?
    func updateDetailView(restaurantDetailModel: RestaurantDetailModel) {
        updateDetailViewCalled = true
        updateDetailViewPassedRestaurantDetail = restaurantDetailModel
    }
}
