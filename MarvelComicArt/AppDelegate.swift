import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var appCoordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		let window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
		appCoordinator = CoordinatorFactory.app(window: window)
		appCoordinator?.start()
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {

	}

	func applicationDidEnterBackground(_ application: UIApplication) {

	}

	func applicationWillEnterForeground(_ application: UIApplication) {

	}

	func applicationDidBecomeActive(_ application: UIApplication) {

	}

	func applicationWillTerminate(_ application: UIApplication) {

	}


}

