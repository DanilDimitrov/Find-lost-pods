//
//  SettingsViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var favorites: UIImageView!
    @IBOutlet weak var home: UIImageView!
    @IBOutlet weak var history: UIImageView!
    @IBOutlet weak var faq: UIImageView!
    @IBOutlet weak var hide_unknown_devices: UISwitch!
    @IBOutlet weak var rate_us: UIImageView!
    @IBOutlet weak var share_app: UIImageView!
    @IBOutlet weak var privacy_policy: UIImageView!
    @IBOutlet weak var terms_of_use: UIImageView!
    
    let defaults = UserDefaults.standard
    
    var urlForShare = "https://www.google.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.cornerRadius = 28
        
        conrols()
    }
    
    
    private func conrols(){
        let favoritesTapGesture = UITapGestureRecognizer(target: self, action: #selector(favoritesTapped))
        favorites.addGestureRecognizer(favoritesTapGesture)
        favorites.isUserInteractionEnabled = true
        
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
        home.addGestureRecognizer(homeTapGesture)
        home.isUserInteractionEnabled = true
        
        let termsOfUseTapGesture = UITapGestureRecognizer(target: self, action: #selector(termsofUseTapped))
        terms_of_use.addGestureRecognizer(termsOfUseTapGesture)
        terms_of_use.isUserInteractionEnabled = true
        
        let privacyPolicyTapGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyTapped))
        privacy_policy.addGestureRecognizer(privacyPolicyTapGesture)
        privacy_policy.isUserInteractionEnabled = true
        
        let faqTapGesture = UITapGestureRecognizer(target: self, action: #selector(faqTapped))
        faq.addGestureRecognizer(faqTapGesture)
        faq.isUserInteractionEnabled = true
        
        let shareTapGesture = UITapGestureRecognizer(target: self, action: #selector(shareTapped))
        share_app.addGestureRecognizer(shareTapGesture)
        share_app.isUserInteractionEnabled = true
        
        let rateTapGesture = UITapGestureRecognizer(target: self, action: #selector(rateTapped))
        rate_us.addGestureRecognizer(rateTapGesture)
        rate_us.isUserInteractionEnabled = true
        
        hide_unknown_devices.addTarget(self, action: #selector(hideUnknownDevices(_:)), for: .valueChanged)
        
        let hide_unknown_device = defaults.bool(forKey: "hide_unknown_devices")
        
        if hide_unknown_device {
            hide_unknown_devices.setOn(true, animated: true)
        }else {
            hide_unknown_devices.setOn(false, animated: true)
        }
        
        let historyTapGesture = UITapGestureRecognizer(target: self, action: #selector(historyTapped))
        history.addGestureRecognizer(historyTapGesture)
        history.isUserInteractionEnabled = true
        
    }
    
    @objc private func historyTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favoritesViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteDevicesViewConroller") as? FavoriteDevicesViewConroller {
            favoritesViewController.fromHistory = true
            self.navigationController?.pushViewController(favoritesViewController, animated: true)
        }
    }
    
    @objc func hideUnknownDevices(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "hide_unknown_devices")
    }
    
    @objc private func rateTapped() {
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            AppStore.requestReview(in: windowScene)
        }
    }
    
    @objc private func shareTapped() {
        guard let url = URL(string: urlForShare) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Не удалось открыть URL: \(url)")
        }
    }
    
    @objc private func faqTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewConroller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewConroller.name_of_html_for_label = "FAQ"
            webViewConroller.name_of_html_file = "faq"
            self.navigationController?.pushViewController(webViewConroller, animated: true)
        }
    }
    
    @objc private func privacyPolicyTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewConroller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewConroller.name_of_html_for_label = "Privacy Policy"
            webViewConroller.name_of_html_file = "privacypolicy"
            self.navigationController?.pushViewController(webViewConroller, animated: true)
        }
    }
    
    @objc private func termsofUseTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewConroller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewConroller.name_of_html_for_label = "Terms Of Use"
            webViewConroller.name_of_html_file = "termsofuse"
            self.navigationController?.pushViewController(webViewConroller, animated: true)
        }
    }
    
    @objc private func favoritesTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favoriteDevicesViewConroller = storyboard.instantiateViewController(withIdentifier: "FavoriteDevicesViewConroller") as? FavoriteDevicesViewConroller {
            self.navigationController?.pushViewController(favoriteDevicesViewConroller, animated: true)
        }
    }
    
    
    
    @objc private func homeTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}
