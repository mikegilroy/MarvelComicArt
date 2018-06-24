import Foundation

class Coordinator {
	
	private var subCoordinators: [Coordinator] = []
	
	func addCoordinator(_ coordinator: Coordinator) {
		subCoordinators.append(coordinator)
	}
	
	func removeCoordinator(_ coordinator: Coordinator) {
		subCoordinators = subCoordinators.filter({!($0 === coordinator)})
	}
}
