//
//  LocalStorage.swift
//  Sunshine
//
//  Created by Jerry Hanks on 24/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
class LocalStorage {
    private static let userDefault = UserDefaults(suiteName: "sunshine_pref")!
    
    static var preferredCityName:String?{
        get { return userDefault.string(forKey: keyPrefCityName)}
        set(value){userDefault.setValue(value, forKey: keyPrefCityName)}
    }
    
    static var preferredUnit:String?{
        get{return userDefault.string(forKey:keyPrefferdUnit )}
        set(value){userDefault.setValue(value, forKey: keyPrefferdUnit)}
    }
    
    static var isNotificationEnabled:Bool{
        get{return userDefault.bool(forKey: keyNotifications)}
        set(value){userDefault.setValue(value, forKey: keyNotifications)}
    }
    
    
    static func clear(){
        let dictionary = userDefault.dictionaryRepresentation()
        dictionary.keys.forEach { key in userDefault.removeObject(forKey: key)}
        
        print(Array(userDefault.dictionaryRepresentation().keys).count)
    }
    
    
    private static let keyPrefCityName = "sunshine+pref_city_name"
    private static let keyPrefferdUnit = "sunshine+pref_unit"
    private static let keyNotifications = "sunshine+pref_notif"
    
}
