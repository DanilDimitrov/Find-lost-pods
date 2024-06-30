//
//  WebViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var name: UILabel!

    var name_of_html_for_label = ""
    var name_of_html_file = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = name_of_html_for_label

        if let htmlPath = Bundle.main.path(forResource: name_of_html_file, ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(url, allowingReadAccessTo: url)
        } else {
            print("HTML file not found.")
        }
        
        prepareBack()
    }
    
    private func prepareBack(){
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        back.addGestureRecognizer(backTapGesture)
        back.isUserInteractionEnabled = true
    }
    
    @objc private func backTapped() {
        dismiss(animated: true, completion: nil)
    }
}
