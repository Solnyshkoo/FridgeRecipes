import UIKit

protocol CusineStackViewProtocol: AnyObject {
    func cusinePressed(name: String)
}

final class CusineStackView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var delegate: CusineStackViewProtocol?
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
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
    
    func c(del: CusineStackViewProtocol) {
        delegate = del
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
    private let nameString = ["Chinese", "French", "Greek", "Italian", "Japanese", "Mexican", "American", "British", "Irish"]
    private let imagesString = ["chinese", "french", "greek", "italy", "japan", "mexic", "American", "British", "Irish"]
    private func setupStackCategore() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private func initSubviews() {
        let gestureRecognizer1 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            let l = self.nameString[0]
            self.delegate?.cusinePressed(name: l)
        }
        
        let gestureRecognizer2 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[1])
        }
        
        let gestureRecognizer3 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[2])
        }
        
        let gestureRecognizer4 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[3])
        }
        
        let gestureRecognizer5 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[4])
        }
        
        let gestureRecognizer6 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[5])
        }
        
        let gestureRecognizer7 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[6])
        }
        
        let gestureRecognizer8 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[7])
        }
        
        let gestureRecognizer9 = BindableGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.delegate?.cusinePressed(name: self.nameString[8])
        }
        
        threeDoubles[0].addGestureRecognizer(gestureRecognizer1)
        threeDoubles[1].addGestureRecognizer(gestureRecognizer2)
        threeDoubles[2].addGestureRecognizer(gestureRecognizer3)
        threeDoubles[3].addGestureRecognizer(gestureRecognizer4)
        threeDoubles[4].addGestureRecognizer(gestureRecognizer5)
        threeDoubles[5].addGestureRecognizer(gestureRecognizer6)
        threeDoubles[6].addGestureRecognizer(gestureRecognizer7)
        threeDoubles[7].addGestureRecognizer(gestureRecognizer8)
        threeDoubles[8].addGestureRecognizer(gestureRecognizer9)

        var l = 0
        threeDoubles.forEach { item in
            item.configureUI(img: UIImage(named: imagesString[l]))
            l += 1
            stackView.addSubview(item)
        }
    }
}
