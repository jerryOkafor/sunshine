//
//  Dictionary+Extensions.swift
//  Sunshine
//
//  Created by Jerry Hanks on 20/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation

// MARK: Dictionary
extension Dictionary {
    func removeNullValues() -> [AnyHashable: Any] {
        var dict: [AnyHashable: Any] = self
        
        let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
        let keysToCheck = dict.keys.filter({ dict[$0] is Dictionary })
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        for key in keysToCheck {
            if let valueDict = dict[key] as? [AnyHashable: Any] {
                dict.updateValue(valueDict.removeNullValues(), forKey: key)
            }
        }
        return dict
    }
}
