//
//  BRTakeHomeTests.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import XCTest
@testable import BRTakeHome

class LunchPresnterTests: XCTestCase {
    
    var lunchPresenter : LunchPresenter?
    var mockLunchView = MockLunchView()
    var mocklunchService = MockLunchService()
    
    override func setUpWithError() throws {
        lunchPresenter = LunchPresenter(lunchView: mockLunchView, lunchService: mocklunchService)
        if let presenter = lunchPresenter {
            // This is called when the presenter is instantiated so it's fine to do here in setup
            presenter.fetchResaurants()
            
            // Wait until our async call finishes.  Should be quick
            waitForBooleanExpectation(timeout: 2) {
                presenter.restaurants.count > 0
            }
        } else {
            // Uh....
            XCTFail("Never should have got here")
        }
    }
    
    func testFetchRestaurant_success() {
        // Since fetch is called in setup, I can just assert here that it has been called
        XCTAssertTrue(mocklunchService.fetchRestaurantsCalled)
    }
    
    func testGetRestaurant_validIndex() {
        // Get our first restaurant.  Mock returns one so there should be a value here.
        let val = lunchPresenter?.getRestaurant(atIndex: 0)
        XCTAssertNotNil(val)
    }
    
    func testFetchImageForRestaurant() {
        
        // Get image for first restaurant
        lunchPresenter?.fetchImageForRestaurant(atIndex: 0)
        
        // Make sure that fetch image was called
        XCTAssertTrue(mocklunchService.fetchRestaurantImageCalled)
        waitForBooleanExpectation(timeout: 2) {
            self.mockLunchView.imageReceivedCalled
        }
        // Since we waited for imageReceived to be called on the view, these values should also be set by this time
        XCTAssertNotNil(mockLunchView.imageRecievedPassedValImage)
        XCTAssertEqual(0, mockLunchView.imageReceivedPassedValForIndex)
    }
    
    func testRestaurantSelected() {
        lunchPresenter?.restaurantSelected(atIndex: 0)
        
        XCTAssertTrue(mockLunchView.navigateToDetailViewCalled)
        XCTAssertEqual(lunchPresenter?.restaurants[0].name, mockLunchView.navigateToDetailViewPassedRestaurant?.name)
    }
    
    func testMapSelected() {
        lunchPresenter?.mapSelected()
        XCTAssertTrue(mockLunchView.navigateToMapViewCalled)
    }
    
}
