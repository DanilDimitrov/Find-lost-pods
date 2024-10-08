//
//  SearchResultViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var helpCenterLabel: UILabel!
    @IBOutlet weak var countOfDevices: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favorites: UIImageView!
    @IBOutlet weak var settings: UIImageView!
    @IBOutlet weak var history: UIImageView!
    
    var devices: [BluetoothDevice] = [BluetoothDevice(name: "Unknown Device",
                                                                   charge: "70%",
                                                                   coordinates: [38.7749, -122.4194],
                                                                   date: Date())]
    
    var hide_unknown_devices = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.cornerRadius = 28
        helpCenterLabel.attributedText = underlineText(helpCenterLabel.text!)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        hide_unknown_devices = defaults.bool(forKey: "hide_unknown_devices")
        
        if hide_unknown_devices {
               devices = devices.filter { $0.name != "Unknown Device" }
           }
        
        countOfDevices.text = "Found devices: \(devices.count)"
        
        setupGestures()
    }
    
    @objc private func historyTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func underlineText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        return attributedString
    }
    
    @IBAction func searchAgain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchDevicesViewController = storyboard.instantiateViewController(withIdentifier: "SearchDevicesViewController") as? SearchDevicesViewController {
            self.navigationController?.pushViewController(searchDevicesViewController, animated: true)
        }
    }
    
    private func setupGestures() {
        let favoritesTapGesture = UITapGestureRecognizer(target: self, action: #selector(favoritesTapped))
        favorites.addGestureRecognizer(favoritesTapGesture)
        favorites.isUserInteractionEnabled = true
        
        let settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        settings.addGestureRecognizer(settingsTapGesture)
        settings.isUserInteractionEnabled = true
        
        let historyTapGesture = UITapGestureRecognizer(target: self, action: #selector(historyTapped))
        history.addGestureRecognizer(historyTapGesture)
        history.isUserInteractionEnabled = true
        
        let helpCenterTapGesture = UITapGestureRecognizer(target: self, action: #selector(helpCenterTapped))
        helpCenterLabel.addGestureRecognizer(helpCenterTapGesture)
        helpCenterLabel.isUserInteractionEnabled = true
    }
    
    @objc private func helpCenterTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewConroller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewConroller.name_of_html_for_label = "FAQ"
            webViewConroller.name_of_html_file = "faq"
            self.navigationController?.pushViewController(webViewConroller, animated: true)
        }
    }
    
    @objc private func favoritesTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favoriteDevicesViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteDevicesViewConroller") as? FavoriteDevicesViewConroller {
            self.navigationController?.pushViewController(favoriteDevicesViewController, animated: true)

        }
    }
    
    @objc private func settingsTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        }
    }
}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let device = devices[indexPath.section]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutBluetoothDeviceViewController") as? AboutBluetoothDeviceViewController {
            aboutViewController.modalPresentationStyle = .fullScreen
            aboutViewController.device = device
            self.navigationController?.pushViewController(aboutViewController, animated: true)
        } else {
            print("AboutBluetoothDeviceViewController not found")
        }
    }
    
    
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoundBluetoothDeviceTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoundBluetoothDeviceTableViewCell
        
        let device = devices[indexPath.section]
        cell.nameString = device.name
        cell.dateString = "\(device.date ?? Date())"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
