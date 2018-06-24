import Foundation
import CryptoSwift

protocol MarvelAPIClientProtocol {
	func getComics(limit: Int, offset: Int, completion: @escaping (_ offset: Int, _ results: [ComicWebModel]?) -> Void)
	func getComicImage(atPath path: String, completion: @escaping (UIImage?) -> Void)
}

class MarvelAPIClient: MarvelAPIClientProtocol {
	
	private let baseUrl = URL(string: "https://gateway.marvel.com:443/v1/public")!
	private let comicsPath = "comics"
	private let privateKey = "8592993efce8335e3a179c2bb6c3e09db0abbd06"
	private let publicKey = "2b4e7adb67720d9bc69bbe4fbb413eea"
	
	private let httpClient: HTTPClientProtocol
	
	private enum ParameterKey: String {
		case hash
		case timestamp = "ts"
		case limit
		case offset
		case apiKey = "apikey"
		case format
		case orderBy
	}
	
	private enum ParameterValue: String {
		case comic
		case focDate
	}
	
	init(httpClient: HTTPClientProtocol) {
		self.httpClient = httpClient
	}
	
	func getComics(limit: Int, offset: Int, completion: @escaping (_ offset: Int, _ results: [ComicWebModel]?) -> Void) {
		
		let url = baseUrl.appendingPathComponent(comicsPath)
		
		var parameters = authorizationParameters()
		parameters[ParameterKey.limit.rawValue] = limit
		parameters[ParameterKey.offset.rawValue] = offset
		parameters[ParameterKey.format.rawValue] = ParameterValue.comic.rawValue
		parameters[ParameterKey.orderBy.rawValue] = ParameterValue.focDate.rawValue
		
		DispatchQueue.global(qos: .userInitiated).async {
			[unowned self] in
			self.httpClient.get(type: ComicsResponseWebModel.self, fromUrl: url, parameters: parameters) { (response) in
				guard let results = response?.data?.results,
					let offset = response?.data?.offset else {
						completion(0, nil)
						return
				}
				completion(offset, results)
			}
		}
	}
	
	func getComicImage(atPath path: String, completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: path) else {
			completion(nil)
			return
		}
		
		let parameters = authorizationParameters()
		
		DispatchQueue.global(qos: .background).async {
			[unowned self] in
			self.httpClient.getImage(fromUrl: url, parameters: parameters) { (image) in
				completion(image)
			}
		}
	}
	
	private func authorizationParameters() -> [String: Any] {
		let timestamp = Date().timeIntervalSince1970.description
		let hash = (timestamp + privateKey + publicKey).md5()
		
		let parameters: [String: Any] = [
			ParameterKey.hash.rawValue: hash,
			ParameterKey.timestamp.rawValue: timestamp,
			ParameterKey.apiKey.rawValue: publicKey
		]
		return parameters
	}
}
