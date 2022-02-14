//
//  MapViewPresenter.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/13/22.
//

import Foundation


class MapViewPresenter {
    var lunchService : LunchServiceProtocol
    var mapView : MapViewProtocol
    private var _restaurants : [Restaurant]
    
    
    public init(mapView: MapViewProtocol, lunchService:LunchServiceProtocol) {
        self.mapView = mapView
        self.lunchService = lunchService
        
        _restaurants = [Restaurant]()
        
        fetchResaurants()
    }
    
    public func fetchResaurants() {
        lunchService.fetchRestaurants { result in
            switch result {
            case .success(let restaurants):
                self._restaurants = restaurants
                self.updateMap()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func dismissSelected() {
        mapView.dismissMap()
    }
    
    private func updateMap() {
        for restaurant in _restaurants {
            let mapAnnotation = MapAnnotationModel(latitude: restaurant.location.lat, longitude: restaurant.location.lng, name: restaurant.name)
            mapView.addAnnotation(annotationModel: mapAnnotation)
        }
    }
}
