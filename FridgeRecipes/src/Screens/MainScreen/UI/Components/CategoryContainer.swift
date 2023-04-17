import UIKit

final class CategoryContainer: UIView {
    private let view = CategoryView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    func configureUI(img: UIImage?) {
        view.configureUI(img: img)
        addSubview(view)
        view.frame = CGRect(x: 7, y: 7, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: view.intrinsicContentSize.width + 14, height: view.intrinsicContentSize.height + 14)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CategoryView: UIView {
    private let imageView: UIImageView = .init(frame: .zero)
    private let rightWidth = (UIScreen.main.bounds.width - 60) / 3

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: rightWidth, height: rightWidth * 1.1)
    }

    func configureUI(img: UIImage?) {
        imageView.image = img
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        imageView.frame = CGRect(x: 0, y: 0, width: rightWidth, height: rightWidth * 1.1)
    }
}
