import UIKit
import Cartography

class ComicDetailViewController: UIViewController {

	class ComicDetailViewControllerActions {
		var didTapClose: (() -> Void)?
	}
	var actions = ComicDetailViewControllerActions()
	
	private var imageView: UIImageView!
	private var summaryView: ComicSummaryView!
	private var scrollView: UIScrollView!
	private var scrollContentView: UIView!
	
	private var detailViewOffset: CGFloat {
		return view.frame.size.height / 1.4
	}
	
	private let viewModel: ComicDetailViewModel
	
	init(viewModel: ComicDetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureViews()
		configureNavigationBar()
		loadComic()
    }
	
	@objc private func closeTapped(sender: UIBarButtonItem) {
		actions.didTapClose?()
	}
	
	private func loadComic() {
		imageView.image = viewModel.comic.thumbnailImage
		summaryView.configure(title: viewModel.comic.title, description: viewModel.comic.description)
		view.layoutSubviews()
	}
	
	private func configureViews() {
		view.backgroundColor = .darkGray
		configureImageView()
		configureScrollView()
		configureSummaryView()
	}
	
	private func configureImageView() {
		imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		view.addSubview(imageView)
		
		constrain(imageView, view) {
			imageView, view in
			imageView.top == view.safeAreaLayoutGuide.top
			imageView.left == view.safeAreaLayoutGuide.left
			imageView.right == view.safeAreaLayoutGuide.right
			imageView.height == view.height / 1.5
		}
	}
	
	private func configureScrollView() {
		scrollView = UIScrollView()
		scrollView.contentInset = UIEdgeInsets(top: detailViewOffset, left: 0, bottom: 0, right: 0)
		view.addSubview(scrollView)
		
		scrollContentView = UIView()
		scrollView.addSubview(scrollContentView)
		
		constrain(scrollContentView, scrollView, view) {
			scrollContentView, scrollView, view in
			
			
			scrollContentView.edges == scrollView.edges
			scrollContentView.width == view.width
			scrollView.edges == view.edges
			scrollView.width == view.width
			scrollView.height == view.height
		}
	}
	
	private func configureSummaryView() {
		summaryView = ComicSummaryView()
		scrollContentView.addSubview(summaryView)
		
		constrain(scrollView, summaryView, view) {
			scrollView, summaryView, view in
			
			summaryView.leading == scrollView.leading
			summaryView.trailing == scrollView.trailing
			summaryView.bottom == scrollView.bottom
			summaryView.top == scrollView.top
			summaryView.height >= view.height - detailViewOffset
		}
	}
	
	private func configureNavigationBar() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			title: viewModel.closeButtonTitle,
			style: .plain,
			target: self,
			action: #selector(closeTapped(sender:))
		)
	}
}
