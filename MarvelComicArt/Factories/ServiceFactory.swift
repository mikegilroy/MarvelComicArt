import Foundation

class ServiceFactory {
	
	class func comics() -> ComicsServiceProtocol {
		let httpClient = HTTPClient()
		let apiClient = MarvelAPIClient(httpClient: httpClient)
		return ComicsService(apiClient: apiClient)
	}
}
