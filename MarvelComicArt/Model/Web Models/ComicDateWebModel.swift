import Foundation

struct ComicDateWebModel: Codable {
	
	let type: String?
	let date: Date?
	
	enum DateType: String, Codable {
		case onsaleDate
		case focDate
	}
	
	private enum CodingKeys: String, CodingKey  {
		case type
		case date
	}
}
