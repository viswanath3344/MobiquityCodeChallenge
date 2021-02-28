//
//  LocationSelectionControllerViewController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 27/02/21.
//

import UIKit
import MapKit

class LocationSelectionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var selectedLocation : FavouriteLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Location"
        confirmButton.isHidden = true
        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(triggerTouchAction(gestureReconizer:)))
        gestureRecognizer.minimumPressDuration = 2.0
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func triggerTouchAction(gestureReconizer: UITapGestureRecognizer) {
        //Add alert to show it works
        
        clearMap()
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        let mapLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapLocation.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            annotation.title = city
            annotation.subtitle = country
            self.selectedLocation = FavouriteLocation(city: city, country: country, latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.confirmButton.isHidden = false
            
        }
        
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        guard let location = selectedLocation else {
            return
        }
        FavouriteLocationsDataController.shared.addLocation(location: location)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func clearMap()  { // To Remove previously selected location.
        mapView.annotations.forEach { (annotaion) in
            mapView.removeAnnotation(annotaion)
        }
        confirmButton.isHidden = true
        
    }
    
}


