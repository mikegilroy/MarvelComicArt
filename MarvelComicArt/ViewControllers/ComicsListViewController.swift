import UIKit
import Cartography

class ComicsListViewController: UIViewController {
	
	class ComicsListViewControllerActions {
		var didSelectComic: ((Comic) -> Void)?
	}
	var actions = ComicsListViewControllerActions()
	
	private var collectionView: UICollectionView!
	private var backgroundImageView: UIImageView!
	private var loadingIndicator: UIActivityIndicatorView!
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	private var collectionViewDelegate: ComicsListCollectionViewDelegate!
	private let viewModel: ComicListViewModel
	
	init(viewModel: ComicListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()
		configureCollectionView()
		loadComics()
	}
	
	private func configureCollectionView() {
		collectionViewDelegate = ComicsListCollectionViewDelegate(collectionView: collectionView, viewModel: viewModel)
		collectionViewDelegate.actions.didSelectComic = {
			[weak self] comic in
			self?.actions.didSelectComic?(comic)
		}
	}
	
	private func configureViews() {
		backgroundImageView = UIImageView(frame: view.bounds)
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.image = #imageLiteral(resourceName: "space")
		view.addSubview(backgroundImageView)
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
		view.addSubview(collectionView)
		
		loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
		loadingIndicator.hidesWhenStopped = true
		collectionView.addSubview(loadingIndicator)
		
		constrain(loadingIndicator, collectionView, backgroundImageView, view) {
			loadingIndicator, collectionView, backgroundImageView, view in
			
			loadingIndicator.center == view.center
			collectionView.edges == view.safeAreaLayoutGuide.edges
			backgroundImageView.edges == view.edges
		}
	}
	
	private func loadComics() {
		loadingIndicator.startAnimating()
		viewModel.loadComics {
			[weak self] in
			DispatchQueue.main.async {
				self?.loadingIndicator.stopAnimating()
				self?.collectionView.reloadData()
			}
		}
	}
}
