import UIKit

final class CusineStackView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search by cuisine"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setupStackCategore()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: offsetFirst, height: offsetheight * 3 + offsetY)
    }
    
    func config() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor)

        ])
    }

    var offsetFirst: CGFloat = 0
    var offsetSecond: CGFloat = 0
    var offsetThird: CGFloat = 0
    var offsetheight: CGFloat = 0
    var offsetY: CGFloat = 0
    private let threeDoubles = (0 ... 8).map { _ in CategoryContainer(frame: .zero) }
    private let imagesString = ["chinese", "french", "greek", "italy", "japan", "mexic"]
    private func setupStackCategore() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let allViews = stackView.subviews
        for item in allViews {
            stackView.removeArrangedSubview(item)
        }
        stackView.addSubview(titleText)
        var l = 0
        threeDoubles.forEach { item in
            if l >= 6 {
                item.configureUI(img: UIImage(systemName: "person"))
            
            } else {
                item.configureUI(img: UIImage(named: imagesString[l]))
            }
            l += 1
            stackView.addSubview(item)
        }
        
        var i = 0

        for view in stackView.subviews {
            if i >= 7 {
                view.frame = CGRect(x: offsetThird, y: (offsetY + view.intrinsicContentSize.height * 2) , width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetThird += view.intrinsicContentSize.width
            } else if i == 0 {
                view.frame = CGRect(x: 10, y: 0, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetY += view.intrinsicContentSize.height
            } else if i >= 4 {
                view.frame = CGRect(x: offsetSecond, y: offsetY + view.intrinsicContentSize.height, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetSecond += view.intrinsicContentSize.width
            } else {
                view.frame = CGRect(x: offsetFirst, y: offsetY, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetFirst += view.intrinsicContentSize.width
            }
            offsetheight = view.intrinsicContentSize.height
            i += 1
        }
    }
}
