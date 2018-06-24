import Foundation

struct ComicImageWebModel: Codable {
	
	let path: String?
	let fileExtension: String?
	
	var url: String? {
		guard let path = path, let fileExtension = fileExtension else { return nil }
		return path.appending(".\(fileExtension)")
	}
	
	private enum CodingKeys: String, CodingKey {
		case path
		case fileExtension = "extension"
	}
}
