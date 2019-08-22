
import Foundation
struct Wind : Codable {
	let speed : Double
	let deg : Double

	enum CodingKeys: String, CodingKey {

		case speed = "speed"
		case deg = "deg"
	}

	
}
