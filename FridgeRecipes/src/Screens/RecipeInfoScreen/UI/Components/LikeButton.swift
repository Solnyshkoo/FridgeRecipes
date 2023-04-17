import UIKit

final class LikeButton: UIButton {
    private enum Constants {
        static let config = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .bold,
            scale: .medium
        )
        static let fillIcon = UIImage(named: "heart-full")?.withRenderingMode(.alwaysTemplate)
        static let contourIcon = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        static let activeTint: UIColor = .red
        static let notActiveTint: UIColor = .label
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 35, height: 35)
    }

    var isLiked: Bool {
        didSet {
            updateImage()
        }
    }

    private func updateImage() {
        switch isLiked {
        case true:
            setImage(Constants.fillIcon, for: .normal)
            tintColor = Constants.activeTint
        case false:
            setImage(Constants.contourIcon, for: .normal)
            tintColor = Constants.notActiveTint
        }
    }

    init() {
        isLiked = false
        super.init(frame: .zero)
        updateImage()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CookedButton: UIButton {
    private enum Constants {
        static let config = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .bold,
            scale: .medium
        )
        static let fillIcon = UIImage(named: "cooked2")?.withRenderingMode(.alwaysTemplate)
        static let contourIcon = UIImage(named: "cooked")?.withRenderingMode(.alwaysTemplate)
        static let activeTint: UIColor = .systemBlue
        static let notActiveTint: UIColor = .label
    }

    var isCooked: Bool {
        didSet {
            updateImage()
        }
    }

    private func updateImage() {
        switch isCooked {
        case true:
            setImage(Constants.fillIcon, for: .normal)
            tintColor = Constants.activeTint
        case false:
            setImage(Constants.contourIcon, for: .normal)
            tintColor = Constants.notActiveTint
        }
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 35, height: 35)
    }

    init() {
        isCooked = false
        super.init(frame: .zero)
        imageView?.contentMode = .scaleAspectFit
        updateImage()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
