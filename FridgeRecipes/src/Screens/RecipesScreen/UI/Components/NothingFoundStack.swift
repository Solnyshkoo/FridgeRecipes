import UIKit

final class NothingFoundStack: UIStackView {
    // MARK: - Constants

    private enum Constants {
        static let nothingFoundEmojiLabelFont = UIFont.systemFont(ofSize: 50)
        static let nothingFoundTitleLabelFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let nothingFoundDescriptionLabelFont = UIFont.systemFont(ofSize: 15)
        static let nothingFoundSpacing: CGFloat = 5
        static let maxWidth: CGFloat = 300
    }

    // MARK: - Fields

    private let emojiLabel = UILabel()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configUI()
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Config UI

    private func configUI() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = Constants.nothingFoundSpacing

        emojiLabel.font = Constants.nothingFoundEmojiLabelFont
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.text = "🔎"

        titleLabel.font = Constants.nothingFoundTitleLabelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Nothing found"

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
}
