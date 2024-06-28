//
//  GradientView.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var middleColor: UIColor = .gray {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }
    
    
    override class var layerClass: AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateColors() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ startColor.cgColor, middleColor.cgColor, endColor.cgColor]
        
    }
}
