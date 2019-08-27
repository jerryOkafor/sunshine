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
    @IBOutlet weak var locationLabel: SettingsItemVeiw!
    @IBOutlet weak var unitLabel: SettingsItemVeiw!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#73767f")
        
        self.locationLabel.value = LocalStorage.preferredCityName ?? ApiClient.defaultCityName
        self.unitLabel.value = LocalStorage.preferredUnit ?? ApiClient.defaultUnit
        self.notificationSwitch.isOn = LocalStorage.isNotificationEnabled
    }
    
    @IBAction func onToggleNotificationSwitch(_ sender: UISwitch) {
        LocalStorage.isNotificationEnabled = sender.isOn
    }
    
    @IBAction func onTapLocationBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Location", message: "",preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter location"
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .clear
            textField.keyboardType = .alphabet
            textField.delegate = self
        }
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let prefCityName = alert.textFields?[0].text{
                guard !prefCityName.isEmpty else {return}
                
                LocalStorage.preferredCityName = prefCityName
                self.locationLabel.value = prefCityName
                
                NotificationCenter.default.post(name: .cityNamePrefChanged, object: nil)
            }
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
        let initialSelection  = LocalStorage.preferredUnit == "Metric" ? 0 : 1
        ActionSheetStringPicker.show(withTitle: "Preferred Unit", rows: ["Metric", "Imperial"], initialSelection: initialSelection, doneBlock: { picker, index, value in
            if let valueStr = value as? String{
                LocalStorage.preferredUnit = valueStr
                self.unitLabel.value = valueStr
                
                NotificationCenter.default.post(name: .unitPrefChanged, object: nil)
            }
            
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}


//For Location TextField
extension SettingsViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count == 0{
            return true
        }
        
        let characterSet = CharacterSet(charactersIn: ",.-/:;()$&@\"'?!")
        
        if string.rangeOfCharacter(from: characterSet) != nil{
            return false
        }
        
        if string == " "{
            return false
        }
        
        return true
    }
}
