//
//  BRTakeHomeTests.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import XCTest
@testable import BRTakeHome

class LunchPresnterTests: XCTestCase {
    
    var presenter : RestaurantListViewPresenter?
    var mockLunchView = MockRestaurantListView()
    var mocklunchService = MockLunchService()
    
    override func setUpWithError() throws {
        presenter = RestaurantListViewPresenter(lunchView: mockLunchView, lunchService: mocklunchService)
        if let presenter = presenter {
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
        let val = presenter?.getRestaurant(atIndex: 0)
        XCTAssertNotNil(val)
    }
    
    func testFetchImageForRestaurant() {
        
        // Get image for first restaurant
        presenter?.fetchImageForRestaurant(atIndex: 0)
        
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
        presenter?.restaurantSelected(atIndex: 0)
        
        XCTAssertTrue(mockLunchView.navigateToDetailViewCalled)
        XCTAssertEqual(presenter?.restaurants[0].name, mockLunchView.navigateToDetailViewPassedRestaurant?.name)
    }
    
    func testMapSelected() {
        presenter?.mapSelected()
        XCTAssertTrue(mockLunchView.navigateToMapViewCalled)
    }
    
}
