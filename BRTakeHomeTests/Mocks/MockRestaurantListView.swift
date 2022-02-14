//
//  MockLunchView.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import UIKit
@testable import BRTakeHome

class MockRestaurantListView : RestaurantListViewProtocol {
    
    public var navigateToDetailViewCalled = false
    public var navigateToDetailViewPassedRestaurant : Restaurant?
    func navigateToDetailView(withRestaurant: Restaurant) {
        navigateToDetailViewCalled = true
        navigateToDetailViewPassedRestaurant = withRestaurant
    }
    
    public var navigateToMapViewCalled = false
    func navigateToMapView() {
        navigateToMapViewCalled = true
    }
    
    
    public init () {
        
    }
    
    public var restaurantsReceivedCalled = false
    func restaurantsReceived() {
        restaurantsReceivedCalled = true
    }
    
    public var imageReceivedCalled = false
    public var imageRecievedPassedValImage : UIImage? = nil
    public var imageReceivedPassedValForIndex : Int? = nil
    func imageReceived(image: UIImage, forIndex: Int) {
        imageReceivedCalled = true
        imageRecievedPassedValImage = image
        imageReceivedPassedValForIndex = forIndex
    }
    
    
}
