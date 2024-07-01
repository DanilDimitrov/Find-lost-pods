//
//  SearchDevicesViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import UIKit

class SearchDevicesViewController: UIViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    
    var bluetoothViewModel: BluetoothViewModel!
    var scanTimer: Timer?
    var progressValue: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bluetoothViewModel = BluetoothViewModel()
        startScan()
    }
    
    func startScan() {
        scanTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        scanTimer?.fire()
    }
    
    @objc func updateUI() {
        switch searchLabel.text {
        case "Searching...":
            searchLabel.text = "Searching."
        case "Searching.":
            searchLabel.text = "Searching.."
        case "Searching..":
            searchLabel.text = "Searching..."
        default:
            searchLabel.text = "Searching..."
        }
        
        progressValue += 100.0 / 30.0
        progressLabel.text = "\(Int(progressValue))%"
        
        if progressValue >= 100.0 {
            scanTimer?.invalidate()
            scanTimer = nil
            go_to_device_list()
            
        }
    }
    
    deinit {
        scanTimer?.invalidate()
        scanTimer = nil
    }
    
    private func go_to_device_list() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchResultViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController {
            searchResultViewController.devices = bluetoothViewModel.foundDevices()
            self.navigationController?.pushViewController(searchResultViewController, animated: true)
        }
    }
}
