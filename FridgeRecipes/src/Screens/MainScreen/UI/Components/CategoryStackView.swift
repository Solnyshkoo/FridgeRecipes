import UIKit

protocol CategoryStackViewProtocol: AnyObject {
    func wasPressed(name: String)
}

final class CategoryStackView: UIView {
    // MARK: - Fields

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = "Search by category"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var delegate: CategoryStackViewProtocol?
    private let categoryContainers = (0 ... 5).map { _ in CategoryContainer(frame: .zero) }
    private let nameString = ["Breakfast", "Dessert", "Seafood", "Miscellaneous", "Vegetarian", "Starter"]
    private var offsetFirst: CGFloat = 0
    private var offsetSecond: CGFloat = 0
    private var offsetheight: CGFloat = 0
    private var offsetY: CGFloat = 0
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackCategory()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        CGSize(width: offsetFirst, height: offsetheight * 2 + offsetY)
    }
    
    // MARK: - Config

    func config(deleg: CategoryStackViewProtocol) {
        delegate = deleg
    }

    // MARK: - Setup Stack Category

    private func setupStackCategory() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor)

        ])

        let allViews = stackView.subviews
        for item in allViews {
            stackView.removeArrangedSubview(item)
        }
        stackView.addSubview(titleText)
      
        var count = 0
        categoryContainers.forEach { item in
            item.tag = count
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:))))
            item.configureUI(img: UIImage(named: nameString[count]))
            count += 1
            stackView.addSubview(item)
        }
        
        var i = 0

        for view in stackView.subviews {
            if i >= 4 {
                view.frame = CGRect(x: offsetSecond, y: offsetY + view.intrinsicContentSize.height, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetSecond += view.intrinsicContentSize.width
            } else if i == 0 {
                view.frame = CGRect(x: 10, y: 0, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetY += view.intrinsicContentSize.height
            } else {
                view.frame = CGRect(x: offsetFirst, y: offsetY, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
                offsetFirst += view.intrinsicContentSize.width
            }
            offsetheight = view.intrinsicContentSize.height
            i += 1
        }
    }
    
    // MARK: - Action

    @objc
    func categoryTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else {
            return
        }
        delegate?.wasPressed(name: nameString[index])
    }
}
