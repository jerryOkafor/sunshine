//
//  SettingsViewController.swift
//  Sunshine
//
//  Created by Jerry Hanks on 21/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#73767f")
    }
    
    @IBAction func onToggleNotificationSwitch(_ sender: Any) {
    }
    
    @IBAction func onTapLocationBtn(_ sender: Any) {
    }
    
    @IBAction func onTapUnitBtn(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
