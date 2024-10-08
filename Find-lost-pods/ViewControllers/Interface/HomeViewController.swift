//
//  HomeViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 28.06.2024.
//

import UIKit
import CoreBluetooth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var helpCenterLabel: UILabel!
    
    @IBOutlet weak var settings: UIImageView!
    @IBOutlet weak var favorites: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.cornerRadius = 25
        helpCenterLabel.attributedText = underlineText(helpCenterLabel.text!)
        helpCenterLabel.textColor = .white
        
        setupGestures()
        
    }
    
    private func setupGestures() {
        let favoritesTapGesture = UITapGestureRecognizer(target: self, action: #selector(favoritesTapped))
        favorites.addGestureRecognizer(favoritesTapGesture)
        favorites.isUserInteractionEnabled = true
        
        let settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        settings.addGestureRecognizer(settingsTapGesture)
        settings.isUserInteractionEnabled = true
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func underlineText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        return attributedString
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchDevicesViewController = storyboard.instantiateViewController(withIdentifier: "SearchDevicesViewController") as? SearchDevicesViewController {
            self.navigationController?.pushViewController(searchDevicesViewController, animated: true)

        }
    }
    
    
}




