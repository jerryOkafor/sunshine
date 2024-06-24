//
//  ApiCleint+Extension.swift
//  Sunshine
//
//  Created by Jerry Hanks on 20/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
extension ApiClient{
    static let defaultCityName = "Edmonton" //Edmont, CA
    static let defaultUnit = "Metric"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
}


enum Configuration{
    
    //MARK:- Public API - API Key
    static var apiKey : String{
        string(for: "API_KEY")
    }
    
    // MARK: - Helper methods
    static private func string(for key: String) -> String {
            Bundle.main.infoDictionary?[key] as! String
        }
}
