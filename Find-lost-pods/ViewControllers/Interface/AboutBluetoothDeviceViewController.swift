//
//  AboutBluetoothDeviceViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 28.06.2024.
//

import UIKit
import MapKit
import CoreLocation

class AboutBluetoothDeviceViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension AboutBluetoothDeviceViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Ошибка при получении местоположения: \(error.localizedDescription)")
        }
}
