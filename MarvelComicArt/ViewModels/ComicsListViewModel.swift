import UIKit

class ComicListViewModel {
	
	var comics = [Comic]()
	
	private(set) var comicImages = NSCache<NSNumber, UIImage>()
	
	private let limit: Int = 20
	private var offset: Int = 0

	private let comicsService: ComicsServiceProtocol
	
	init(comicsService: ComicsServiceProtocol) {
		self.comicsService = comicsService
	}
	
	func loadComics(completion: @escaping () -> Void) {
		
		guard offset == comics.count else { return }
		
		comicsService.getComics(limit: limit, offset: offset) { (offset, comics) in
			if let comics = comics,
				offset == self.offset {
				self.comics.append(contentsOf: comics)
				self.offset += comics.count
			}
			completion()
		}
	}
	
	func loadCellViewModel(forItem item: Int, completion: @escaping (ComicCellViewModel) -> Void) {
		let comic = comics[item]
		comicsService.getComicImage(comic: comic) {
			[weak self] (image) in
			if let image = image {
				self?.comicImages.setObject(image, forKey: NSNumber(value: item))
			}
			let viewModel = ComicCellViewModel(imagePath: comic.thumbnailPath, image: image)
			completion(viewModel)
		}
	}
	
	/// Returns comic for current item. Returns nil if comic image is not loaded. 
	func comic(forItem item: Int) -> Comic? {
		guard let comicImage = comicImages.object(forKey: NSNumber(value: item)) else { return nil }
		var comic = comics[item]
		comic.thumbnailImage = comicImage
		return comic
	}
}
