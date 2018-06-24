import UIKit

class ComicsListCollectionViewDelegate: NSObject {

	class ComicsListCollectionViewDelegateActions {
		var didSelectComic: ((Comic) -> Void)?
	}
	var actions = ComicsListCollectionViewDelegateActions()
	
	private let comicCellIdentifier = "comicCell"
	private let cellRows: CGFloat = 4
	private let cellColums: CGFloat = 3
	private let columnPadding: CGFloat = 0.2
	private let interItemSpacing: CGFloat = 20
	private let lineSpacing: CGFloat = 20
	private let collectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
	
	private lazy var itemHeight: CGFloat = {
		let totalIteritemSpacing = (cellRows - 1) * interItemSpacing
		let totalHeight = collectionView.bounds.height - (collectionInset.top + collectionInset.bottom)
		return (totalHeight - totalIteritemSpacing) / cellRows
	}()
	
	private lazy var itemWidth: CGFloat = {
		let paddedColumns = cellColums + columnPadding
		let wholeColums: CGFloat = cellColums
		let totalLineSpacing = (wholeColums - 1) * lineSpacing
		let totalWidth = collectionView.bounds.width - (collectionInset.left + collectionInset.right)
		return (totalWidth - totalLineSpacing) / paddedColumns
	}()
	
	private lazy var itemSize: CGSize = {
		return CGSize(width: itemWidth, height: itemHeight)
	}()
	
	private unowned let collectionView: UICollectionView
	private unowned let viewModel: ComicListViewModel
	
	init(collectionView: UICollectionView, viewModel: ComicListViewModel) {
		self.collectionView = collectionView
		self.viewModel = viewModel
		super.init()
		configureCollectionView()
	}
	
	private func configureCollectionView() {
		collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: comicCellIdentifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .clear
	}
}

extension ComicsListCollectionViewDelegate: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.comics.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comicCellIdentifier, for: indexPath) as! ComicCollectionViewCell
		
		let item = indexPath.item
		cell.identifier = item
		
		viewModel.loadCellViewModel(forItem: item) {
			[weak cell] (cellViewModel) in
			// Cells are reusable, so we must check item id matches cell identifier before updating cell data to prevent setting incorrect data
			guard let id = cell?.identifier, id == item else { return }
			DispatchQueue.main.async {
				cell?.configure(with: cellViewModel)
			}
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard indexPath.item == viewModel.comics.count - 1 else { return }
		viewModel.loadComics {
			[weak collectionView] in
			DispatchQueue.main.async {
				collectionView?.reloadData()
			}
		}
	}
}

extension ComicsListCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
	
	// MARK: - UICollectionViewDelegate
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		guard let comic = viewModel.comic(forItem: indexPath.item) else { return }
		actions.didSelectComic?(comic)
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return itemSize
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return lineSpacing
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return interItemSpacing
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return collectionInset
	}
}
