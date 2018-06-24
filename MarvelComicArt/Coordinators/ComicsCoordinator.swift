import UIKit

class ComicsCoordinator: Coordinator {
	
	private let navigationRouter: UINavigationController
	
	init(navigationRouter: UINavigationController) {
		self.navigationRouter = navigationRouter
	}
	
	func start(isNavigationBarHidden: Bool = true) {
		let comicsListViewController = ViewControllerFactory.comicsList()
		comicsListViewController.actions.didSelectComic = {
			[weak self] comic in
			self?.goToComicDetail(comic: comic)
		}
		
		navigationRouter.isNavigationBarHidden = isNavigationBarHidden
		navigationRouter.pushViewController(comicsListViewController, animated: false)
	}
	
	func goToComicDetail(comic: Comic) {
		let comicDetailViewController = ViewControllerFactory.comicDetail(comic: comic)
		comicDetailViewController.actions.didTapClose = {
			[weak self] in
			self?.navigationRouter.dismiss(animated: true, completion: nil)
		}
		let embededComicDetail = UINavigationController()
		embededComicDetail.pushViewController(comicDetailViewController, animated: false)
		navigationRouter.present(embededComicDetail, animated: true, completion: nil)
	}
}
