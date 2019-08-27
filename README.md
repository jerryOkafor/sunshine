# Sunshine
Sunshine is wether tracking app that allows the user to query weather data from [OpenWeather Api](https://openweathermap.org/forecast5) for five days at three hours interval. 

5 day forecast is available at any location or city. It includes weather data every 3 hours. Forecast is available in JSON or XML format.

For the purpose of this project, we consume all api in JSON.

## Installation
Sunshine uses external `Pods`, simply `cd` to the folder where you have sunshine and open `Sunshine.xcworkspace` and not `Sunshine.xcproject`

## Description
Sunshine is composed of three ViewController:

<img src="./screenshots/IMG_3889.png" alt="HomeViewController" title="A cute kitten"  style="max-width:30%;" /> 
<img src="./screenshots/IMG_3890.png" alt="DetailsViewController" title="A cute kitten"  style="max-width:30%;" /> 
<img src="./screenshots/IMG_3892.jpg" alt="SwtingsViewController" title="A cute kitten"  style="max-width:30%;" />


* **HomeViewController**

	HomeViecntrolle presents the five day forcast in swipable viewpager. Users can swipe to any day in the five days and the hourly forcast is displayed accordinly.
	
	The pager card displays the date of the day, the appropriate weather icon, the temperature and the day as `Today`, `Tomorrow` or the day of the week if the day is not `Today` or `Tomorrow`.
	
	The HomeViewController also has a `Page control Indicator` at the bottom of the swipable pager which indicated the selected pager position. 
	
	The HomeViewController presents the 3 hourly forecast in a grid of 8 items - which is the maxmum forcats you can have for any give day.
	
	When a forcast is tapped, the app navigates the user to the `DetailsViewController`.


* **DetailsViewController**
	
	The `DetailsViewController` shows more info about the selected forecast including humidity, presure max and min temp and the weather descripption.
	
	To view other hours, you can tap the arror - left and right  - icons at the bottom of the screen.
	
	The DetailsViewcontroller presents the icon of the selected forcast.

* **SettingsViewController**

	The `SettingsViewController` enables the user to  choose a  location for the forecast, choose a preferred formatting unit  - `Imperial` or `Metric` and aslo to toggle notification on and off.
	
	
## API
Suuchine consumes the following `REST` API from from [OpenWeather Api](https://openweathermap.org/forecast5)

* `api.openweathermap.org/data/2.5/forecast?q={city name},{country code}`
	
	`q city name and country code divided by comma, use ISO 3166 country codes`


## Todo
Implement notifications.	




## Dependencies and Pods
* CoreDate
* [Alamofire ~> 5.0.0-beta.5](https://github.com/Alamofire/Alamofire) 
* [RxSwift ~> 5.0](https://github.com/ReactiveX/RxSwift)
* [RxCocoa ~> 5.0](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
* [RxSwiftExt ~> 5.0](https://github.com/RxSwiftCommunity/RxSwiftExt)
* [RxOptional](https://github.com/RxSwiftCommunity/RxOptional)
* [SnapKit ~> 4.0.0](https://github.com/SnapKit/SnapKit)
* [FSPagerView](https://github.com/WenchaoD/FSPagerView)
* [R.swift](https://github.com/mac-cain13/R.swift)
* [Then](https://github.com/devxoul/Then)
* [ActionSheetPicker-3.0 ~> 2.3.0](https://github.com/skywinder/ActionSheetPicker-3.0)


## Focus
1. Making Network Request (Get , Post , Put , Delete)
2. Using a web servers
3. Parsing JSON file using Codable (Decodable , Encodable)
4. Asynchronous Requests
5. MVC Pattern with Network (Create Cleaner Code) GCD and Queues
7. Persisting app state and user data using `UserDefualt` and `CoreData`
8. Polished UI and a good UX

## Requirements
XCode >= 10.3
