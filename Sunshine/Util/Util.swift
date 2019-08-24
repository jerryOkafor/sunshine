//
//  Util.swift
//  Sunshine
//
//  Created by Jerry Hanks on 23/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class Util {
    
    public static func parseDate(_ dateStr:String,readFormat:String = "yyyy-MM-dd HH:mm:ss",displayFormat:String = "MMM d, yyyy HH:mm:ss") -> String?{
        let readDateFormatter = DateFormatter().then{$0.dateFormat = readFormat}
        
        if let date = readDateFormatter.date(from: dateStr){
            let displayDateFormatter = DateFormatter().then{$0.dateFormat = displayFormat}
            return  displayDateFormatter.string(from: date)
            
        }else{
            return nil
        }
    }
    
    public static func getDayOfWeek(_ dateStr:String,readFormat: String = "yyyy-MM-dd") -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = readFormat
        guard let date = formatter.date(from: dateStr) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }
    
    public static func getDayOfWeekText(_ dateStr:String,readFormat: String = "yyyy-MM-dd") -> String{
        let formatter  = DateFormatter().then{$0.dateFormat = readFormat}
        
        guard let date = formatter.date(from: dateStr) else { return "Today" }
        let myCalendar = Calendar(identifier: .gregorian)
        
        if myCalendar.isDateInToday(date){ return "Today"
        }else if myCalendar.isDateInTomorrow(date){
            return "Tomorrow"
        }else{
            let displayDateFormatter = DateFormatter().then{$0.dateFormat = "EEEE"}
            return  displayDateFormatter.string(from: date)
        }
        
    }
    
    public static func formatTemperature(isMetric : Bool = true, temp : Double) -> String{
        var temp = temp
        if isMetric{
            temp = temp - 273.15 //(temp * 1.8) + 32
        }
        
        return "\(Int(temp))°"
    }
    
    public static func getImageForWeatherCondition(weatherId : Int) -> UIImage? {
        // Based on weather code data found at:
        // http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
        if (weatherId >= 200 && weatherId <= 232) {
            return R.image.icStorm()!
        } else if (weatherId >= 300 && weatherId <= 321) {
            return R.image.icLightRain()!
        } else if (weatherId >= 500 && weatherId <= 504) {
            return R.image.icRain()!
        } else if (weatherId == 511) {
            return R.image.icSnow()!
        } else if (weatherId >= 520 && weatherId <= 531) {
            return R.image.icRain()!
        } else if (weatherId >= 600 && weatherId <= 622) {
            return R.image.icSnow()!
        } else if (weatherId >= 701 && weatherId < 761) {
            return R.image.icFogCopy()!
        } else if (weatherId == 761 || weatherId == 781) {
            return R.image.icStorm()!
        } else if (weatherId == 800) {
            return R.image.icClear()!
        } else if (weatherId == 801) {
            return R.image.icLightClouds()!;
        } else if (weatherId >= 802 && weatherId <= 804) {
            return R.image.icCloudy()!;
        }
        return nil
    }
}
