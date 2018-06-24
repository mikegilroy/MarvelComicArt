import UIKit

class CoordinatorFactory {
	
	class func app(window: UIWindow) -> AppCoordinator {
		return AppCoordinator(window: window)
	}	
	
	class func comics(navigationRouter: UINavigationController) -> ComicsCoordinator {
		return ComicsCoordinator(navigationRouter: navigationRouter)
	}
}
