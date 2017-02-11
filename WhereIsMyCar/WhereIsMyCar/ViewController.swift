//
//  ViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 11/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var coreLocationManager = CLLocationManager()
    
    var locationManager:LocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addLocation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) || coreLocationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            if Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil {
                self.coreLocationManager.requestWhenInUseAuthorization()
            } else {
                print("No description provider")
            }
        }
        self.coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.coreLocationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.05, 0.05))
        
        self.mapView.setRegion(region, animated: true)
        
        //addLocationPoint(location: locations.last!)
        
        self.coreLocationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : " + error.localizedDescription)
    }
    
    func addLocationPoint(location:CLLocation){
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

