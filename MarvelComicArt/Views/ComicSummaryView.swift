import UIKit
import Cartography

class ComicSummaryView: UIView {
	
	private var blurView: UIVisualEffectView!
	private var stackView: UIStackView!
	private var titleLabel: UILabel!
	private var descriptionLabel: UILabel!
	private let margin: CGFloat = 20
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(title: String?, description: String?) {
		titleLabel.text = title
		descriptionLabel.text = description
		descriptionLabel.isHidden = description == nil
		layoutIfNeeded()
	}
	
	private func configureViews() {
		blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
		addSubview(blurView)
		
		stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = margin
		blurView.contentView.addSubview(stackView)
		
		titleLabel = UILabel()
		titleLabel.textColor = .white
		titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		titleLabel.numberOfLines = 0
		titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		stackView.addArrangedSubview(titleLabel)
		
		descriptionLabel = UILabel()
		descriptionLabel.textColor = .white
		descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		stackView.addArrangedSubview(descriptionLabel)
		
		constrain(stackView, blurView, self) {
			stackView, blurView, view in
			
			blurView.edges == view.edges
			
			stackView.leading == blurView.leading + margin
			stackView.top == blurView.top + margin
			stackView.bottom == blurView.bottom - margin
			stackView.trailing == blurView.trailing - margin
		}
	}
}
