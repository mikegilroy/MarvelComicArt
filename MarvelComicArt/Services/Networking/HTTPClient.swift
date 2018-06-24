import Foundation
import Alamofire
import AlamofireImage

protocol HTTPClientProtocol {
	func get<T: DateCodable>(type: T.Type, fromUrl url: URL, parameters: [String: Any]?, completion: @escaping (T?) -> Void)
	func getImage(fromUrl url: URL, parameters: [String: Any]?, completion: @escaping (UIImage?) -> Void)
}

class HTTPClient: HTTPClientProtocol {
	
	private let imageCache = AutoPurgingImageCache()
	
	func get<T: DateCodable>(type: T.Type, fromUrl url: URL, parameters: [String: Any]?, completion: @escaping (T?) -> Void) {

		Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
			guard let data = response.data else {
				completion(nil)
				return
			}
			
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = T.dateDecodingStrategy
		
			let result = try? decoder.decode(T.self, from: data)
			completion(result)
		}
	}
	
	func getImage(fromUrl url: URL, parameters: [String: Any]?, completion: @escaping (UIImage?) -> Void) {
		
		if let image = imageCache.image(withIdentifier: url.absoluteString) {
			completion(image)
			return
		}
		
		Alamofire.request(url, method: .get, parameters: parameters).responseImage {
			[weak self] (response) in
			if let image = response.value {
				self?.imageCache.add(image, withIdentifier: url.absoluteString)
			}
			completion(response.value)
		}
	}
}
