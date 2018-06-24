import Foundation

struct ComicPriceWebModel: Codable {
	
	let type: String?
	let price: Double?
	
	enum PriceType: String, Codable {
		case print = "printPrice"
	}
	
	private enum CodingKeys: CodingKey, String {
		case type
		case price
	}
}
