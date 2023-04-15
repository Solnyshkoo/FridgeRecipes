import UIKit

final class StoriesStackView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setnum()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    private let threeDoubles = (0...10).map() {_ in StoriesContainer(frame: .zero) }
    private let imagesString = ["first_recipe", "second_recipe", "third_recipe"]
    private func setnum() {
        let allViews = stackView.arrangedSubviews
        for item in allViews {
            stackView.removeArrangedSubview(item)
        }
        
        var i = 0
        threeDoubles.forEach { item in
            if i < 3 {
                item.configureUI(img: UIImage(named: imagesString[i]))
            } else {
                item.configureUI(img: UIImage(systemName: "person"))
            }
            i += 1
            
            stackView.addArrangedSubview(item)
        }
        for view in stackView.arrangedSubviews {
            view.frame = CGRect(x: 0, y: 0, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        }
        
    }
}

final class StoriesContainer: UIView {
    
   
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.secondarySystemBackground.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0.0, 0.4, 1]
        return gradient
    }()

    private let view = StorieView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    func configureUI(img: UIImage?) {
        view.configureUI(img: img)
        addSubview(view)
        view.frame = CGRect(x: 5, y: 5, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        gradient.frame = CGRect(x: 5, y: 5, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        gradient.cornerRadius = 25
        layer.addSublayer(gradient)
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 190)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class StorieView: UIView {

    private let imageView: UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 180)
    }
    
    func configureUI(img: UIImage?) {
//        imageView.backgroundColor = .blue
        imageView.image = img
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
    
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 180)
    }
}
