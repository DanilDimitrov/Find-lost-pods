//
//  SecondSplashScreen.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

class SecondSplashScreen: UIViewController{
    
    
    @IBAction func continueButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "ThirdSplashScreen") as? ThirdSplashScreen {
            mainViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
