//
//  ViewController.swift
//  FollowMe
//
//  Created by Samuel Putnam on 4/30/16.
//  Copyright © 2016 Sam Putnam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up location manager
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Only want location services to be used when using the app
        self.locationManager.requestWhenInUseAuthorization()
        // Turns on location manager
        self.locationManager.startUpdatingLocation()
        // Show the blue dot
        self.mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        // MARK - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get last location of locations that have been passed in
        let location = locations.last
        // Get center of that location, i.e. latitude and longitude from that location variable
        let center =  CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        //  Area for map to zoom to. A smaller number zooms further in. Zooming into user's current location.
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:1, longitudeDelta: 1))
    
        self.mapView.setRegion(region, animated: true)
        //Now that user's current location is known the location can be stopped from updating.
        self.locationManager.stopUpdatingLocation()
    }
    //handles case if location manager has an error
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print ("Errors: "  + error.localizedDescription)
    }
    
}

