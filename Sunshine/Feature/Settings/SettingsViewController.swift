//
//  SettingsViewController.swift
//  Sunshine
//
//  Created by Jerry Hanks on 21/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

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
        
        let alert = UIAlertController(title: "New Location", message: "",preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter location"
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .clear
        }
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        alert.textFields?.forEach {
            $0.superview?.backgroundColor = .clear
            $0.superview?.superview?.subviews[0].removeFromSuperview()
        }
    }
    
    @IBAction func onTapUnitBtn(_ sender: Any) {
        
        ActionSheetStringPicker.show(withTitle: "Preffered Unit", rows: ["Metric", "Imperial"], initialSelection: 0, doneBlock: { picker, index, values in
            print("values = \(values)")
            print("indexes = \(index)")
            print("picker = \(picker)")
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
