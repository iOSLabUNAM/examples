//
//  ViewController.swift
//  MapKitCoreLocation
//
//  Created by Luis Ezcurdia on 5/24/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    let locationManager = CLLocationManager()

    @IBOutlet weak var map: MKMapView!
    let initialLocation = CLLocation(latitude: 37.7843, longitude: -122.4007)
    let regionRadius: CLLocationDistance = 50000

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        enableBasicLocationServices()
        centerMapOnLocation(location: initialLocation)
        addLocations()
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func addLocations() {
        let artwork = Artwork(title: "Yoda",
                              locationName: "ILM",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 37.798894, longitude: -122.4508267))
        map.addAnnotation(artwork)
    }

}

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func enableBasicLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            enableMyWhenInUseFeatures()
            break
        @unknown default:
            print("Oups something went wrong")
        }
    }
    
    func disableMyLocationBasedFeatures() {
        print("disabling...")
    }
    
    func enableMyWhenInUseFeatures() {
        print("enabling...")
        guard checkForLocationServices() else { return }
        startReceivingLocationChanges()
        
    }
    
    func checkForLocationServices() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            print("Location services are available")
            return true
        } else {
            print("location services are unavailable")
            return false
        }
    }
    
    func startReceivingLocationChanges() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        print("ALT: \(lastLocation.altitude), LAT: \(lastLocation.coordinate.latitude), LON: \(lastLocation.coordinate.longitude)")
        // Do something with the location.
    }
}

