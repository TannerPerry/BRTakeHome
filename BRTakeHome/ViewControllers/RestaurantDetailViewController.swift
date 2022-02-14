//
//  RestaurantDetailViewViewController.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/11/22.
//

import UIKit
import MapKit
import MessageUI

protocol RestaurantDetailViewProtocol {
    func annotateMap(mapAnnotation: MapAnnotationModel)
    func updateDetailView(restaurantDetailModel:RestaurantDetailModel)
    func makeCall(phoneNumberURL:URL)
    func navigateToMapView()
}

class RestaurantDetailViewController: UIViewController {
    
    
    @IBOutlet weak var restaurantMapView: MKMapView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantStreelLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantPhoneLabel: UILabel!
    @IBOutlet weak var restaurantTwitterLabel: UILabel!
    
    
    var restaurant: Restaurant?
    var detailViewPresenter : RestaurantDetailViewPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let r = restaurant else {
            print("Should have had a restaurant here")
            return
        }
        detailViewPresenter = RestaurantDetailViewPresenter(detailView: self, restaurant:r)
    }
    
    @objc func makeCall(_ sender: UITapGestureRecognizer){
        detailViewPresenter?.phoneNumberTapped()
    }
    
    @IBAction func mapButtonPressed(_ sender: Any) {
        detailViewPresenter?.mapSelected()
    }
    
    
}// end of class

extension RestaurantDetailViewController : RestaurantDetailViewProtocol {
    func annotateMap(mapAnnotation: MapAnnotationModel) {
        let annotation = MKPointAnnotation()
        annotation.title = mapAnnotation.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapAnnotation.latitude, longitude: mapAnnotation.longitude)
        self.restaurantMapView.addAnnotation(annotation)
        self.restaurantMapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapAnnotation.latitude, longitude: mapAnnotation.longitude), latitudinalMeters: 800, longitudinalMeters: 800), animated: true)
        
    }
    
    func updateDetailView(restaurantDetailModel:RestaurantDetailModel) {
        let r = restaurantDetailModel
        self.restaurantNameLabel.text = r.name
        self.restaurantCategoryLabel.text = r.category
        if let phoneNumber = r.formattedPhoneNumber {
            self.restaurantPhoneLabel.text = phoneNumber
            self.restaurantPhoneLabel.textColor = .blue
            self.restaurantPhoneLabel.isUserInteractionEnabled = true
            let phoneTapped = UITapGestureRecognizer(target: self, action: #selector(self.makeCall(_:)))
            self.restaurantPhoneLabel.addGestureRecognizer(phoneTapped)
        } else {
            self.restaurantPhoneLabel.text = "No Phone Number"
        }
        if let twitterHandle = r.twitterHandle {
            self.restaurantTwitterLabel.text = "@\(twitterHandle)"
        } else {
            self.restaurantTwitterLabel.text = "No Twitter Handle"
        }
        self.restaurantStreelLabel.text = r.address
        self.restaurantAddressLabel.text = "\(r.city), \(r.state)"
    }
    
    func makeCall(phoneNumberURL:URL) {
        if UIApplication.shared.canOpenURL(phoneNumberURL) {
            UIApplication.shared.open(phoneNumberURL, options: [:], completionHandler: nil)
        }
    }
    
    func navigateToMapView() {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            print("Couldn't find map view")
            return
        }
        self.navigationController?.present(mapVC, animated: true)
    }
}
