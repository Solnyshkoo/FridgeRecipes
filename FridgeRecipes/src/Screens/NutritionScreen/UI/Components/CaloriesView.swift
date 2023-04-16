import UIKit

final class CaloriesView: UIView {
    private enum Constants {
        static let titleFontSize: CGFloat = 38
    }
    
    private let caloriesTitle = UILabel()
    private let caloriesCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
    func config(count: String) {
        caloriesCount.text = count
    }
    
    private func configUI() {
        caloriesTitle.text = "Calories"
        caloriesTitle.numberOfLines = 0
        caloriesTitle.textColor = .label
        caloriesTitle.textAlignment = .left
        caloriesTitle.lineBreakMode = .byWordWrapping
        caloriesTitle.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        caloriesTitle.translatesAutoresizingMaskIntoConstraints = false
        
        caloriesCount.numberOfLines = 0
        caloriesCount.textColor = .label
        caloriesCount.textAlignment = .right
        caloriesCount.lineBreakMode = .byWordWrapping
        caloriesCount.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        caloriesCount.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(caloriesTitle)
        addSubview(caloriesCount)
        
        NSLayoutConstraint.activate([
            caloriesTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            caloriesTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            caloriesTitle.heightAnchor.constraint(equalToConstant: 39),
            caloriesTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            caloriesCount.centerYAnchor.constraint(equalTo: centerYAnchor),
            caloriesCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            caloriesCount.leadingAnchor.constraint(equalTo: leadingAnchor),
            caloriesCount.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
}
