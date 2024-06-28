//
//  FortySplashScreen.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

class FortySplashScreen: UIViewController{
    
    
    @IBAction func continueButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "FreeTrialViewConroller") as? FreeTrialViewConroller {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
