import Foundation

struct ComicWebModel: Codable {
	
	let id: Int?
	let title: String?
	let issueNumber: Int?
	let description: String?
	let upc: String?
	let resourceURI: String?
	let pageCount: Int?
	let format: String?
	let modified: Date?
	let thumbnail: ComicImageWebModel?
	let images: [ComicImageWebModel]?
	let dates: [ComicDateWebModel]?
	let prices: [ComicPriceWebModel]?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case issueNumber
		case description
		case upc
		case resourceURI
		case pageCount
		case format
		case thumbnail
		case images
		case dates
		case prices
		case modified
	}
}
