//
//  HistoryViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 01.07.2024.
//

import UIKit

class HistoryViewController: UIViewController{
    
    var savedArray: [BluetoothDevice] = []
    
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var imageNoDevicesImageView: UIImageView!
    @IBOutlet weak var aboutNoDevicesLabel: UILabel!
    @IBOutlet weak var noDevicesLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDevicesFromDefaults(key: "historyDevices")
        
        setupGestures()
    }
    
    private func setupGestures() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        back.addGestureRecognizer(backTapGesture)
        back.isUserInteractionEnabled = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func loadDevicesFromDefaults(key: String) {
        let defaults = UserDefaults.standard
        
        if let savedDevicesData = defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let loadedDevices = try? decoder.decode([BluetoothDevice].self, from: savedDevicesData) {
                savedArray = loadedDevices
                print("Loaded devices: \(loadedDevices.map { $0.name })")
            } else {
                print("Failed to decode devices from UserDefaults")
            }
        } else {
            print("No devices found in UserDefaults")
        }
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoundBluetoothDeviceTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoundBluetoothDeviceTableViewCell
        
        let device = savedArray[indexPath.section]
        cell.nameString = device.name
        cell.dateString = "\(device.date ?? Date())"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return savedArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let device = savedArray[indexPath.section]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutBluetoothDeviceViewController") as? AboutBluetoothDeviceViewController {
            aboutViewController.device = device
            self.navigationController?.pushViewController(aboutViewController, animated: true)
        } else {
            print("AboutBluetoothDeviceViewController not found")
        }
    }
}

