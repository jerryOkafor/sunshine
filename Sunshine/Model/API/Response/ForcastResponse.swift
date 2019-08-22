//
//  ForcastResponse.swift
//  Sunshine
//
//  Created by Jerry Hanks on 20/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation

struct CoordinateItem:Codable {
    let latitude:Double
    let longitude:Double
    
    enum CodingKeys:String,CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
struct CityItem : Codable {
    let id:Int64
    let name:String
    let coord:CoordinateItem
    let country:String
    let timezone:Int64
    let sunrise:Int64
    let sunset:Int64
}
struct ForcastResponse: Codable {
    let code : String
    let count : Int
    let list : [ForcastItem]
    let city:CityItem
    
    enum CodingKeys : String,CodingKey {
        case code = "cod"
        case count = "cnt"
        case list
        case city
    }
}
