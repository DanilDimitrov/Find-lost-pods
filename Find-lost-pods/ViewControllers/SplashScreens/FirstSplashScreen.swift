//
//  ViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

class FirstSplashScreen: UIViewController {
    
    @IBOutlet private weak var continueButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "SecondSplashScreen") as? SecondSplashScreen {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }


}

