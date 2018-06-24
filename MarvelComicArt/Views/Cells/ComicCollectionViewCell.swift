import UIKit
import Cartography

class ComicCollectionViewCell: UICollectionViewCell {
	
	var identifier: Int?

	private var imageView: UIImageView!
	private var loadingIndicator: UIActivityIndicatorView!
	private let borderWidth: CGFloat = 3
	private let borderColor: UIColor = .white
	private var viewModel: ComicCellViewModel?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		setLoadingIndicator(isLoading: true)
	}
	
	func configure(with viewModel: ComicCellViewModel) {
		imageView.image = viewModel.image
		setLoadingIndicator(isLoading: false)
	}
	
	private func setup() {
		contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
		
		imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.borderWidth = borderWidth
		imageView.layer.borderColor = borderColor.cgColor
		contentView.addSubview(imageView)
		
		loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
		contentView.addSubview(loadingIndicator)
		setLoadingIndicator(isLoading: true)
		
		constrain(imageView, loadingIndicator, contentView) {
			imageView, loadingIndicator, contentView in
			
			imageView.edges == contentView.edges
			loadingIndicator.center == contentView.center
		}
	}
	
	private func setLoadingIndicator(isLoading: Bool) {
		if isLoading {
			loadingIndicator.isHidden = false
			loadingIndicator.startAnimating()
		} else {
			loadingIndicator.stopAnimating()
		}
	}
}
