import UIKit
import CoreLocation
final class NutritionInfoView: UIView {
    private let title = UILabel()
    private let amount = UILabel()
    private let percentage = UILabel()
    private let secondSeparator = UIView()
    
    private enum Constants {
        static let textFontSize: CGFloat = 18
        static let sidesOffset: CGFloat = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
    func config(title: String, amount: String, percentage: String) {
        self.title.text = title
        self.amount.text = amount
        self.percentage.text = percentage + " %"
        configureUI()
    }
    
    private func configureUI() {
        title.numberOfLines = 0
        title.textColor = .label
        title.textAlignment = .left
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        amount.numberOfLines = 0
        amount.textColor = .label
        amount.textAlignment = .left
        amount.lineBreakMode = .byWordWrapping
        amount.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .medium)
        amount.translatesAutoresizingMaskIntoConstraints = false
        
        percentage.numberOfLines = 0
        percentage.textColor = .label
        percentage.textAlignment = .right
        percentage.lineBreakMode = .byWordWrapping
        percentage.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .bold)
        percentage.translatesAutoresizingMaskIntoConstraints = false
       
        secondSeparator.backgroundColor = .secondarySystemBackground
        secondSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        addSubview(amount)
        addSubview(percentage)
        addSubview(secondSeparator)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2 * Constants.sidesOffset),
            title.heightAnchor.constraint(equalToConstant: Constants.textFontSize + 1),
            
            amount.centerYAnchor.constraint(equalTo: centerYAnchor),
            amount.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 5),
            amount.heightAnchor.constraint(equalToConstant: Constants.textFontSize + 1),
            
            percentage.centerYAnchor.constraint(equalTo: centerYAnchor),
            percentage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sidesOffset),
            percentage.heightAnchor.constraint(equalToConstant: Constants.textFontSize + 1),
            
            secondSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondSeparator.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}
