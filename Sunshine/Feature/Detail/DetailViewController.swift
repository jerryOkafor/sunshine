//
//  DetailViewController.swift
//  Sunshine
//
//  Created by Jerry Hanks on 22/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var temIconImageView: UIImageView!
    @IBOutlet weak var humidityLabel: WeatherVeiw!
    @IBOutlet weak var pressureLabel: WeatherVeiw!
    @IBOutlet weak var descLabel: UILabel!
    
    
    var city:CityItem!
    var hourIndex:Int!
    var forecasts:[ForcastItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#73767f")
        
        self.bindHourForcast()
        
    }
    
    private func bindHourForcast(){
         let forecast = self.forecasts[self.hourIndex]
        
        print("Binding forecast Item : \(forecast)")
        
        self.navigationItem.title = "\(self.city.name) @ \(Util.parseDate(forecast.dateString, displayFormat: "ha")!.lowercased())"
        
        self.descLabel.text  = forecast.weather[0].main
        self.maxTempLabel.text = Util.formatTemperature(temp: forecast.main.maxTemp)
        self.minTempLabel.text = Util.formatTemperature(temp: forecast.main.minTemp)
        
        self.temIconImageView.image = Util.getImageForWeatherCondition(weatherId: forecast.weather[0].id)
        
        //bind humity, presure uv index and visibility
        self.humidityLabel.value = "\(forecast.main.humidity)%"
        self.pressureLabel.value = "\(forecast.main.pressure)hPa"
    }
    
    @IBAction func onPrevBtn(_ sender: UIButton) {
        if self.hourIndex - 1 >= 0{
            self.hourIndex = self.hourIndex - 1
            
             self.bindHourForcast()
        }
    }
    
    @IBAction func onNextBtn(_ sender: UIButton) {
        if hourIndex + 1 < forecasts.count{
            self.hourIndex = hourIndex + 1
            
            self.bindHourForcast()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
