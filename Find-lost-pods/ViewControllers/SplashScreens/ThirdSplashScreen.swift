//
//  ThirdSplashScreen.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit
import StoreKit

class ThirdSplashScreen: UIViewController{
    
    
    @IBAction func continueButton(_ sender: Any) {
        requestReview()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "FortySplashScreen") as? FortySplashScreen {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func requestReview() {
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            AppStore.requestReview(in: windowScene)
        }
    }
}
