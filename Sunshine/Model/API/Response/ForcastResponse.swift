//
//  ForcastResponse.swift
//  Sunshine
//
//  Created by Jerry Hanks on 20/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation

struct ForcastResponse: Codable {
    let code : String
    let count : Int
    let list : [ForcastItem]
    
    enum CodingKeys : String,CodingKey {
        case code = "cod"
        case count = "cnt"
        case list
    }
}
