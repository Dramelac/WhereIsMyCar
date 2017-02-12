//
//  ViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 11/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, CLLocationManagerDelegate {

    var coreLocationManager = CLLocationManager()
    
    @IBOutlet weak var follow: UISwitch!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var lastLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) || coreLocationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            if Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil {
                coreLocationManager.requestWhenInUseAuthorization()
            } else {
                print("No description provider")
            }
        }
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        coreLocationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if follow.isOn{
            let location = locations.last
            let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
            let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.01, 0.01))
            mapView.setRegion(region, animated: true)
            
        }
        
        mapView.showsUserLocation = true
        lastLocation = locations.last!
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : " + error.localizedDescription)
    }
    
    func loadLocationPoint(location:CLLocation){
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        follow.setOn(false, animated: false)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddPositionViewController{
            (segue.destination as! AddPositionViewController).data = lastLocation
            loadLocationPoint(location: lastLocation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

