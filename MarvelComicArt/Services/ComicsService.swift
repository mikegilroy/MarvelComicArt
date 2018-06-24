import UIKit

protocol ComicsServiceProtocol {
	func getComics(limit: Int, offset: Int, completion: @escaping (_ offset: Int, _ comics: [Comic]?) -> Void)
	func getComicImage(comic: Comic, completion: @escaping (UIImage?) -> Void)
}

struct ComicsService: ComicsServiceProtocol {
	
	private let apiClient: MarvelAPIClientProtocol
	
	init(apiClient: MarvelAPIClientProtocol) {
		self.apiClient = apiClient
	}
	
	func getComics(limit: Int, offset: Int, completion: @escaping (_ offset: Int, _ comics: [Comic]?) -> Void) {
		apiClient.getComics(limit: limit, offset: offset) { (offset, comicWebModels) in
			let comics = comicWebModels?.compactMap { Comic(webModel: $0) }
			completion(offset, comics)
		}
	}
	
	func getComicImage(comic: Comic, completion: @escaping (UIImage?) -> Void) {
		guard let path = comic.thumbnailPath else {
			completion(nil)
			return
		}
		apiClient.getComicImage(atPath: path, completion: completion)
	}
}
