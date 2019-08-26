
import Foundation
struct WeatherItem : Codable {
	let id : Int64
	let main : String
	let description : String
	let icon : String

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case main = "main"
		case description = "description"
		case icon = "icon"
	}
}
