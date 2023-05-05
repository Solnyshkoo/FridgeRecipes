import UIKit

protocol CusineStackViewProtocol: AnyObject {
    func cusinePressed(name: String)
}

final class CusineStackView: UIView {
    // MARK: - Fields

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = "Search by cuisine"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private var delegate: CusineStackViewProtocol?
    private var offsetFirst: CGFloat = 0
    private var offsetSecond: CGFloat = 0
    private var offsetThird: CGFloat = 0
    private var offsetheight: CGFloat = 0
    private var offsetY: CGFloat = 0
    private let categoryContainers = (0 ... 8).map { _ in CategoryContainer(frame: .zero) }
    private let nameString = [
        "Chinese", "French", "Greek", "Italian", "Japanese", "Mexican", "American", "British", "Irish"
    ]

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackCusine()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        CGSize(width: offsetFirst, height: offsetheight * 3 + offsetY)
    }

    // MARK: - Config

    func config(del: CusineStackViewProtocol) {
        delegate = del
    }

    // MARK: - Setup StackCusine

    private func setupStackCusine() {
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

        initSubviews()

        var i = 0

        for view in stackView.subviews {
            if i >= 7 {
                view.frame = CGRect(x: offsetThird, y: offsetY + view.intrinsicContentSize.height * 2, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
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

    // MARK: - Setup subviews

    private func initSubviews() {
        var count = 0
        categoryContainers.forEach { item in
            item.tag = count
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cusineTapped(_:))))
            item.configureUI(img: UIImage(named: nameString[count]))
            count += 1
            stackView.addSubview(item)
        }
    }

    // MARK: - Action

    @objc
    func cusineTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else {
            return
        }
        delegate?.cusinePressed(name: nameString[index])
    }
}
