import UIKit

final class NutritionInfoView: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let textFontSize: CGFloat = 18
        static let sidesOffset: CGFloat = 15
    }

    // MARK: - Fields

    static let cellId = "NutritionInfoView"
    private let title = UILabel()
    private let amount = UILabel()
    private let percentage = UILabel()
    private let secondSeparator = UIView()
    
    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
    // MARK: - Config data

    func config(data: TotalDaily, persentage: TotalDaily?) {
        title.text = data.label
        amount.text = String(data.quantity.rounded(1)) + data.unit.rawValue
        if persentage == nil {
            percentage.isHidden = true
        } else {
            percentage.isHidden = false
            percentage.text = String(persentage?.quantity.rounded(1) ?? 0.0) + (persentage?.unit.rawValue ?? "")
        }
        
        if data.label == "Fatty acids, total saturated" {
            title.text = "Saturated Fat"
        } else if data.label.isEmpty {
            title.text = "-"
            amount.text = "-"
            percentage.text = "-"
        }
        
        if persentage?.unit ?? Unit.g == Unit.g {
            percentage.text = "-"
        }
        configureUI()
    }
    
    // MARK: - Config UI

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
