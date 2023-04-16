import UIKit
final class NutritionFactory {
    
    private enum Constants {
        static let titleFontSize: CGFloat = 32
        static let secondTitleFontSize: CGFloat = 24
        static let cornerRadius: CGFloat = 15
        static let subtitleFontSize: CGFloat = 15
    }
    
    func makeTittleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Nutrition Facts"
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeSeparaator() -> UIView {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeDiscriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Amount Per Serving"
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.secondTitleFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "% Daily Value "
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .right
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.subtitleFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
