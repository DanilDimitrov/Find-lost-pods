//
//  SplashViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

class SplashViewController: UIViewController{
    
    
    @IBOutlet private weak var fisrt_point: UIImageView!
    @IBOutlet private weak var second_point: UIImageView!
    @IBOutlet private weak var end_point: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateImageViewUp(self.fisrt_point, offset: -10)
        self.animateImageViewUp(self.second_point, offset: -5)
        self.animateImageViewDown(self.end_point, offset: 10)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigateToMainViewController()
        }
    }
    
    private func navigateToMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "FirstSplashScreen") as? FirstSplashScreen {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
    private func animateImageViewUp(_ imageView: UIImageView, offset: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            imageView.transform = CGAffineTransform(translationX: 0, y: offset)
        }) { (_) in
            UIView.animate(withDuration: 0.5) {
                imageView.transform = .identity
            }
        }
    }
    
    private func animateImageViewDown(_ imageView: UIImageView, offset: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            imageView.transform = CGAffineTransform(translationX: 0, y: offset)
        }) { (_) in
            UIView.animate(withDuration: 0.5) {
                imageView.transform = .identity
            }
        }
    }
    
}
