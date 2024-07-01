//
//  FavoriteDevisesViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 28.06.2024.
//

import UIKit

class FavoriteDevicesViewConroller: UIViewController {
    
    @IBOutlet weak var settings: UIImageView!
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var history: UIImageView!
    @IBOutlet weak var home: UIImageView!
    @IBOutlet weak var imageNoDevicesImageView: UIImageView!
    @IBOutlet weak var aboutNoDevicesLabel: UILabel!
    @IBOutlet weak var noDevicesLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var savedArray: [BluetoothDevice] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.cornerRadius = 25
        
        setupGestures()
        
        let defaults = UserDefaults.standard
        
        loadDevicesFromDefaults(key: "favoriteDevices")

        
        if savedArray.isEmpty {
            imageNoDevicesImageView.isHidden = false
            aboutNoDevicesLabel.isHidden = false
            noDevicesLabel.isHidden = false
        }else{
            imageNoDevicesImageView.isHidden = true
            aboutNoDevicesLabel.isHidden = true
            noDevicesLabel.isHidden = true
        }
    }
    
    private func setupGestures() {
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
        home.addGestureRecognizer(homeTapGesture)
        home.isUserInteractionEnabled = true
        
        let settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        settings.addGestureRecognizer(settingsTapGesture)
        settings.isUserInteractionEnabled = true
        
        let historyTapGesture = UITapGestureRecognizer(target: self, action: #selector(historyTapped))
        history.addGestureRecognizer(historyTapGesture)
        history.isUserInteractionEnabled = true
    }
    
    @objc private func historyTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let historyViewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            self.navigationController?.pushViewController(historyViewController, animated: true)
        }
    }
    
    @objc private func homeTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    @objc private func settingsTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        }
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

extension FavoriteDevicesViewConroller: UITableViewDataSource{
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

extension FavoriteDevicesViewConroller: UITableViewDelegate{
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
