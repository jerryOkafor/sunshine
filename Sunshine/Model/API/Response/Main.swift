

import Foundation
struct Main : Codable {
	let temp : Double
	let minTemp : Double
	let maxTemp : Double
	let pressure : Double
	let seaLevel : Double
	let groundLevel : Double
	let humidity : Int64
	let tempKelvin : Double

	enum CodingKeys: String, CodingKey {

		case temp = "temp"
		case minTemp = "temp_min"
		case maxTemp = "temp_max"
		case pressure = "pressure"
		case seaLevel = "sea_level"
		case groundLevel = "grnd_level"
		case humidity = "humidity"
		case tempKelvin = "temp_kf"
	}

}
