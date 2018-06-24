import Foundation

struct ComicsDataWebModel: Codable {
	
	let offset: Int?
	let limit: Int?
	let total: Int?
	let count: Int?
	let results: [ComicWebModel]?
	
	private enum CodingKeys: String, CodingKey {
		case offset
		case limit
		case total
		case count
		case results
	}
}
