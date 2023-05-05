import UIKit

final class StoriesStackView: UIView {
    // MARK: - Fields

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let threeDoubles = (0 ... 2).map { _ in StoriesContainer(frame: .zero) }
    private let imagesString = ["first_recipe", "second_recipe", "third_recipe"]
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        CGSize(width: threeDoubles[0].intrinsicContentSize.width, height: threeDoubles[0].intrinsicContentSize.height)
    }
    
    // MARK: - Setup UI

    private func setup() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor)

        ])
        
        let allViews = stackView.arrangedSubviews
        for item in allViews {
            stackView.removeArrangedSubview(item)
        }
        
        var i = 0
        threeDoubles.forEach { item in

            item.configureUI(img: UIImage(named: imagesString[i]))
            i += 1
            
            stackView.addArrangedSubview(item)
        }
        for view in stackView.arrangedSubviews {
            view.frame = CGRect(x: 0, y: 0, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        }
    }
}
