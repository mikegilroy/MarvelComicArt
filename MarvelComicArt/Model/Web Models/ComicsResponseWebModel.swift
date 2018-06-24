import Foundation

struct ComicsResponseWebModel: DateCodable {
	
	let code: Int?
	let status: String?
	let copyright: String?
	let attributionText: String?
	let attributionHTML: String?
	let etag: String?
	let data: ComicsDataWebModel?
	
	private enum CodingKeys: CodingKey, String {
		case code
		case status
		case copyright
		case attributionText
		case attributionHTML
		case etag
		case data
	}
	
	static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
		return .iso8601
	}
}
