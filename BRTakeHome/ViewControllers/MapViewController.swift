//
//  MapViewController.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/11/22.
//

import UIKit
import MapKit

protocol MapViewProtocol {
    func addAnnotation(annotationModel:MapAnnotationModel)
    func dismissMap()
}

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    private var mapPresenter : MapViewPresenter?
    private var didSetRegion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapPresenter = MapViewPresenter(mapView: self, lunchService: ServiceLocator.shared.lunchService)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        mapPresenter?.dismissSelected()
    }
    
    func setRegion(coordinate:CLLocationCoordinate2D) {
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000), animated: true)
        didSetRegion = true
    }
}

extension MapViewController : MapViewProtocol {
    func addAnnotation(annotationModel: MapAnnotationModel) {
        DispatchQueue.main.async {
            
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.title = annotationModel.name
            mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: annotationModel.latitude,
                                                           longitude: annotationModel.longitude)
            self.mapView.addAnnotation(mapAnnotation)
            !self.didSetRegion ? self.setRegion(coordinate: mapAnnotation.coordinate) : nil
        }
    }
    
    func dismissMap() {
        self.dismiss(animated: true)
    }
}


