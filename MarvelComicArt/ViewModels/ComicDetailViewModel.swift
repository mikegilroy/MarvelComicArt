import Foundation

class ComicDetailViewModel {
	
	let closeButtonTitle = "Home".localized
	
	let comic: Comic
	
	init(comic: Comic) {
		self.comic = comic
	}
}
