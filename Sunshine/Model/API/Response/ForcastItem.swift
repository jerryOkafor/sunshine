
import Foundation

struct ForcastItem : Codable {
	let dateMilli : Int
	let main : Main
	let weather : [WeatherItem]
	let clouds : Clouds
	let wind : Wind
    let rain : [String:Double]?
	let dateString : String

	enum CodingKeys: String, CodingKey {

		case dateMilli = "dt"
		case main = "main"
		case weather = "weather"
		case clouds = "clouds"
		case wind = "wind"
		case rain = "rain"
		case dateString = "dt_txt"
	}
}
