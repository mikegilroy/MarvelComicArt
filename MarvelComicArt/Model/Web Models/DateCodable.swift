import Foundation

protocol DateCodable: Codable {
	static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}
