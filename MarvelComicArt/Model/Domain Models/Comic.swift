import UIKit

struct Comic {
	
	let id: Int
	let title: String
	let thumbnailPath: String?
	let issueNumber: Int
	let pageCount: Int
	let description: String?
	let onSaleDate: Date?
	let printPrice: Double?
	let imageUrls: [String]?
	
	var thumbnailImage: UIImage?
	
	init?(webModel: ComicWebModel) {
		guard let id = webModel.id,
			let title = webModel.title,
			let issueNumber = webModel.issueNumber,
			let pageCount = webModel.pageCount else {
				return nil
		}
		
		self.id = id
		self.title = title
		self.thumbnailPath = webModel.thumbnail?.url
		self.issueNumber = issueNumber
		self.pageCount = pageCount
		self.description = webModel.description
		self.onSaleDate = webModel.dates?.first(where: {$0.type == ComicDateWebModel.DateType.onsaleDate.rawValue})?.date
		self.printPrice = webModel.prices?.first(where: { $0.type == ComicPriceWebModel.PriceType.print.rawValue })?.price
		self.imageUrls = webModel.images?.compactMap { $0.url }
	}
}
