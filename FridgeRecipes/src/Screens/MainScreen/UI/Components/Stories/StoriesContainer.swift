import UIKit

final class StoriesContainer: UIView {
    
    // MARK: - Fields
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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - intrinsicContentSize
    override var intrinsicContentSize: CGSize {
        return CGSize(width: view.intrinsicContentSize.width + 10, height: view.intrinsicContentSize.height + 10)
    }

    
    // MARK: - Configure UI
    func configureUI(img: UIImage?) {
        view.configureUI(img: img)
        addSubview(view)
        view.frame = CGRect(x: 5, y: 5, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        gradient.frame = CGRect(x: 5, y: 5, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        gradient.cornerRadius = 25
        layer.addSublayer(gradient)
    }
}
