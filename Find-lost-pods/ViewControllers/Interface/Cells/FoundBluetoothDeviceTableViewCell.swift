//
//  FoundBluetoothDeviceTableViewCell.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 28.06.2024.
//

import UIKit

class FoundBluetoothDeviceTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var nameString: String? {
        didSet {
            nameLabel.text = nameString
        }
    }
    
    var dateString: String? {
        didSet {
            dateLabel.text = dateString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true
        
        let borderColor = UIColor(red: 50/255, green: 121/255, blue: 137/255, alpha: 0.2)
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = borderColor.cgColor
        
        
    }
    
    
}
