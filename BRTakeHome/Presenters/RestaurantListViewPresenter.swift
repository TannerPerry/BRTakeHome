//
//  RestaurantListViewPresenter.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation

class RestaurantListViewPresenter {
    var lunchView    : RestaurantListViewProtocol
    var lunchService : LunchServiceProtocol
    
    private var _restaurants : [Restaurant]
    
    public init(lunchView:RestaurantListViewProtocol, lunchService:LunchServiceProtocol) {
        self.lunchView = lunchView
        self.lunchService = lunchService
        self._restaurants = [Restaurant]()
        fetchResaurants()
    }
    
    public var restaurants : [Restaurant] {
        return _restaurants
    }
    
    public func fetchResaurants() {
        lunchService.fetchRestaurants { result in
            switch result {
            case .success(let restaurants):
                self._restaurants = restaurants
                self.lunchView.restaurantsReceived()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getRestaurant(atIndex:Int) -> RestaurantListModel? {
        if _restaurants.count-1 >= atIndex {
            let r = _restaurants[atIndex]
            let listModel = RestaurantListModel(name: r.name, category: r.category)
            return listModel
        } else {
            return nil
        }
    }
    
    public func fetchImageForRestaurant(atIndex:Int) {
        if _restaurants.count-1 >= atIndex {
            lunchService.fetchRestaurantImage(restaurant: _restaurants[atIndex]) { result in
                switch result {
                case .success(let image):
                    self.lunchView.imageReceived(image: image, forIndex: atIndex)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func restaurantSelected(atIndex:Int) {
        lunchView.navigateToDetailView(withRestaurant:_restaurants[atIndex])
    }
    
    public func mapSelected() {
        lunchView.navigateToMapView()
    }
}
