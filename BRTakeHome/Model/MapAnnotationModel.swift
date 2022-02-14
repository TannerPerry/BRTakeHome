//
//  MapAnnotation.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/13/22.
//

import Foundation
import MapKit

struct MapAnnotationModel {
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var name : String
    
    public init(latitude:CLLocationDegrees, longitude:CLLocationDegrees, name:String) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}
