//
//  RestaurantDetailViewPresenterTests.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/14/22.
//

import XCTest
@testable import BRTakeHome

class RestaurantDetailViewPresenterTests: XCTestCase {
    
    var detailPresenter : RestaurantDetailViewPresenter?
    var detailView = MockRestaurantDetailView()
    var restaurant : Restaurant?

    override func setUpWithError() throws {
        restaurant = createRestuarant()
        guard let r = restaurant else {
            XCTFail()
            return
        }
        detailPresenter = RestaurantDetailViewPresenter(detailView: detailView, restaurant: r)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupMap()  {
        guard let presenter = detailPresenter, let r = restaurant else {
            XCTFail()
            return
        }
        
        let mapAnnotation = MapAnnotationModel(latitude: r.location.lat, longitude: r.location.lng, name: r.name)
        
        presenter.setupMap()
        XCTAssertTrue(detailView.annotateMapCalled)
        XCTAssertNotNil(detailView.annotateMapPassedMapAnnotation)
        if let mockViewMapAnnotation = detailView.annotateMapPassedMapAnnotation {
            XCTAssertEqual(mockViewMapAnnotation.name, mapAnnotation.name)
        }
    }
    
    func testSetupRestaurantDetail() {
        guard let presenter = detailPresenter, let r = restaurant else {
            XCTFail()
            return
        }
        presenter.setupRestaurantDetail()
        XCTAssertTrue(detailView.updateDetailViewCalled)
        XCTAssertNotNil(detailView.updateDetailViewPassedRestaurantDetail)
        if let detailModel = detailView.updateDetailViewPassedRestaurantDetail {
            XCTAssertEqual(r.name, detailModel.name)
        }
        
    }
    
    func testPhoneNumberTapped() {
        guard let presenter = detailPresenter, let r = restaurant, let phoneNumber = r.contact?.phone, let validURL = URL(string: "tel://\(phoneNumber)") else {
            XCTFail()
            return
        }
        
        presenter.phoneNumberTapped()
        XCTAssertTrue(detailView.makeCallCalled)
        XCTAssertEqual(detailView.makeCallPassedURL, validURL)
    }
    
    func testMapSelected() {
        guard let presenter = detailPresenter else {
            XCTFail()
            return
        }
        
        presenter.mapSelected()
        XCTAssertTrue(detailView.navigateToMapViewCalled)
    }
    
    private func createRestuarant() -> Restaurant {
        let contact = Contact(phone: "phone", formattedPhone: "formattedPhone", twitter: "twitter")
        let location = Location(address: "address", crossStreet: "crossStreet", lat: 100.00, lng: 100.00, postalCode: "postalCode", city: "city", state: "state", formattedAddress: ["addr1", "addr2"])
        return Restaurant(name: "Name", backgroundImageURL: "imageUrl", category: "category", contact: contact, location: location)
    }

}
