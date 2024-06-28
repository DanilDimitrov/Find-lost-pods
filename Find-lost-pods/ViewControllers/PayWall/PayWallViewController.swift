//
//  PayWallViewController.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 27.06.2024.
//

import UIKit

class PayWallViewController: UIViewController{
    
    @IBOutlet weak var week_plan: UIImageView!
    @IBOutlet weak var year_plan: UIImageView!
    @IBOutlet weak var weekView: UIView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var labelWeekAbout: UILabel!
    @IBOutlet weak var labelYearAbout: UILabel!
    @IBOutlet weak var weekPrice: UILabel!
    @IBOutlet weak var yearPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weekTapGesture = UITapGestureRecognizer(target: self, action: #selector(weekPlanTapped))
        week_plan.addGestureRecognizer(weekTapGesture)
        week_plan.isUserInteractionEnabled = true
        
        let yearTapGesture = UITapGestureRecognizer(target: self, action: #selector(yearPlanTapped))
        year_plan.addGestureRecognizer(yearTapGesture)
        year_plan.isUserInteractionEnabled = true
        
        weekView.layer.cornerRadius = 10
        yearView.layer.cornerRadius = 10
        
        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        
    }
    
    @objc func weekPlanTapped() {
        week_plan.image = UIImage(named: "selected_plan")
        year_plan.image = UIImage(named: "no_selected_plan")
    }
    
    @objc func yearPlanTapped() {
        week_plan.image = UIImage(named: "no_selected_plan")
        year_plan.image = UIImage(named: "selected_plan")
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            labelWeekAbout.text = "Get 3 Days Free Trial, then for 7.99$/week"
            weekPrice.text = "7,99 US$"
            labelYearAbout.text = "Get 3 Days Free Trial, then for 39.99$/year"
            yearPrice.text = "39,99 US$"
            labelWeekAbout.textAlignment = .center
            labelYearAbout.textAlignment = .center
            
        } else {
            labelWeekAbout.text = "1 Week for 6.99$"
            weekPrice.text = "6,99 US$"
            labelYearAbout.text = "1 Year for 35.99$"
            yearPrice.text = "35,99 US$"
        }
    }
}
