import UIKit

class AppCoordinator: Coordinator {
	
	private let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func start() {
		let navigationRouter = UINavigationController()
		navigationRouter.navigationBar.prefersLargeTitles = true
		window.rootViewController = navigationRouter
		window.makeKeyAndVisible()
	
		let comicsCoordinator = CoordinatorFactory.comics(navigationRouter: navigationRouter)
		addCoordinator(comicsCoordinator)
		comicsCoordinator.start()
	}
}
