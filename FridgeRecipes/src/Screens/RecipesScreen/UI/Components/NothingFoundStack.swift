import UIKit

final class NothingFoundStack: UIStackView {
    private enum Constants {
        static let nothingFoundEmojiLabelFont = UIFont.systemFont(ofSize: 50)
        static let nothingFoundTitleLabelFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let nothingFoundDescriptionLabelFont = UIFont.systemFont(ofSize: 15)
        static let nothingFoundSpacing: CGFloat = 5
        static let maxWidth: CGFloat = 300
    }

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = Constants.nothingFoundSpacing

        let emojiLabel = UILabel()
        emojiLabel.font = Constants.nothingFoundEmojiLabelFont
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.text = "🔎"

        let titleLabel = UILabel()
        titleLabel.font = Constants.nothingFoundTitleLabelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Nothing found"

        let descLabel = UILabel()
        descLabel.font = Constants.nothingFoundDescriptionLabelFont
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.text = "Please try again with a different request"

        NSLayoutConstraint.activate([
            emojiLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maxWidth),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maxWidth),
            descLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maxWidth),
        ])

        addArrangedSubview(emojiLabel)
        addArrangedSubview(titleLabel)
        addArrangedSubview(descLabel)
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
