import Foundation

class ViewControllerFactory {
	
	class func comicsList() -> ComicsListViewController {
		let comicsService = ServiceFactory.comics()
		let viewModel = ComicListViewModel(comicsService: comicsService)
		return ComicsListViewController(viewModel: viewModel)
	}
	
	class func comicDetail(comic: Comic) -> ComicDetailViewController {
		let viewModel = ComicDetailViewModel(comic: comic)
		return ComicDetailViewController(viewModel: viewModel)
	}
}
