import UIKit

final class IngredientSuggestionCell: UICollectionViewCell {
    static let titleFont = UIFont.systemFont(ofSize: Constants.titleSize, weight: .bold)
    static let cellID = "ingredientCell"
    
    private enum Constants {
//        static let emojiSize: CGFloat = 25
        static let titleSize: CGFloat = 17
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .cellBackgroundColor
        static let activeBackgroundColor: UIColor = .link
        static let labelColor: UIColor = .label
        static let activeLabelColor: UIColor = .systemBackground
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    var ingredientName = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        backgroundColor = Constants.backgroundColor
        layoutMargins = Constants.edgeInsets
        addSubview(ingredientName)
        makeTitleLabel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        ingredientName.frame = bounds
    }
    
    private func makeTitleLabel(){
        ingredientName.font = .systemFont(ofSize: Constants.titleSize, weight: .regular)
        ingredientName.textAlignment = .center
    }
    
    func setActiveState(isActive: Bool) {
        if isActive {
            backgroundColor = Constants.activeBackgroundColor
            ingredientName.textColor = Constants.activeLabelColor
            ingredientName.font = UIFont.systemFont(ofSize: Constants.titleSize, weight: .bold)
        } else {
            backgroundColor = Constants.backgroundColor
            ingredientName.textColor = Constants.labelColor
            ingredientName.font = UIFont.systemFont(ofSize: Constants.titleSize, weight: .regular)
        }
    }
}
