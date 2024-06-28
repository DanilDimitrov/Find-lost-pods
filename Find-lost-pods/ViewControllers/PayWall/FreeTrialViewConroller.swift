//
//  FreeTrialViewConroller.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//


import UIKit

class FreeTrialViewConroller: UIViewController{
    
    @IBOutlet weak var cross: UIImageView!
    @IBOutlet weak var trialLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = trialLabel.text!
        let attributedString = NSMutableAttributedString(string: text)
        
        let boldFont = UIFont.boldSystemFont(ofSize: trialLabel.font.pointSize)
        
        if let range = text.range(of: "3 Days Free Trial") {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.font, value: boldFont, range: nsRange)
        }
        
        if let range = text.range(of: "7,99 US$") {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.font, value: boldFont, range: nsRange)
        }
        
        trialLabel.attributedText = attributedString
        
        let crossTapGesture = UITapGestureRecognizer(target: self, action: #selector(crossTapped))
        cross.addGestureRecognizer(crossTapGesture)
        cross.isUserInteractionEnabled = true
        
    }
    
    @objc func crossTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let payWallViewController = storyboard.instantiateViewController(withIdentifier: "PayWallViewController") as? PayWallViewController {
            payWallViewController.modalPresentationStyle = .fullScreen
            present(payWallViewController, animated: true, completion: nil)
        }
    }
}

