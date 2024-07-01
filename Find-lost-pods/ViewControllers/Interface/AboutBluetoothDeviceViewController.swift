//
//  AboutBluetoothDeviceViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 28.06.2024.
//

import UIKit
import MapKit
import CoreLocation

class AboutBluetoothDeviceViewController: UIViewController {
    
    @IBOutlet weak var nameOfDevice: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var chargeLabel: UILabel!
    @IBOutlet weak var vibroSwitch: UISwitch!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var openMapLabel: UILabel!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var vibroView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var battery: UIImageView!
    @IBOutlet weak var foundUIButton: UIButton!
    @IBOutlet weak var pin: UIImageView!
    
    @IBAction func foundButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var openMapHeigthConstraint: NSLayoutConstraint!
    var map_open = false
    
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    
    var device: BluetoothDevice? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isOpaque = true
        
        nameOfDevice.text = device?.name
        chargeLabel.text = device?.charge
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        backImage.addGestureRecognizer(backTapGesture)
        backImage.isUserInteractionEnabled = true
        
        let mapTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped))
        mapView.addGestureRecognizer(mapTapGesture)
        mapView.isUserInteractionEnabled = true
        
        let pinTapGesture = UITapGestureRecognizer(target: self, action: #selector(pinTapped))
        pin.addGestureRecognizer(pinTapGesture)
        pin.isUserInteractionEnabled = true
        
        soundView.layer.cornerRadius = 15
        vibroView.layer.cornerRadius = 15
        
        addDeviceToDefaults(newDevice: device!, key: "historyDevices")

        
        if let deviceCoordinate = device?.coordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: deviceCoordinate[0], longitude: deviceCoordinate[1])
            mapView.addAnnotation(annotation)
            
            mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func pinTapped() {
        addDeviceToDefaults(newDevice: device!, key: "favoriteDevices")
    }
    
    func addDeviceToDefaults(newDevice: BluetoothDevice, key: String) {
        let defaults = UserDefaults.standard
        
        if let savedDevicesData = defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if var loadedDevices = try? decoder.decode([BluetoothDevice].self, from: savedDevicesData) {
                loadedDevices.append(newDevice)
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(loadedDevices) {
                    defaults.set(encoded, forKey: key)
                    print("Device added to existing array: \(newDevice.name)")
                }
            }
        } else {
            let newDevicesArray = [newDevice]
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newDevicesArray) {
                defaults.set(encoded, forKey: key)
                print("Device added to new array: \(newDevice.name)")
            }
        }
    }

    
    @objc private func mapTapped() {
        if !map_open {
            mapViewHeightConstraint.constant *= 0.5
            openMapHeigthConstraint.constant *= 0.5
            openMapLabel.text = "Hide map"
            map_open = true
            battery.isHidden = true
            soundView.isHidden = true
            vibroView.isHidden = true
            foundUIButton.isHidden = true
        } else {
            mapViewHeightConstraint.constant *= 2
            openMapHeigthConstraint.constant *= 2
            map_open = false
            openMapLabel.text = "Open map"
            battery.isHidden = false
            soundView.isHidden = false
            vibroView.isHidden = false
            foundUIButton.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AboutBluetoothDeviceViewController: MKMapViewDelegate {
    
}
