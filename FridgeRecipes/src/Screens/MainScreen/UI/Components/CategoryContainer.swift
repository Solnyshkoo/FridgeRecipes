import UIKit

final class CategoryContainer: UIView {
    // MARK: - Fields
    private let view = CategoryView(frame: .zero)

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
        return CGSize(width: view.intrinsicContentSize.width + 14, height: view.intrinsicContentSize.height + 14)
    }
    
    // MARK: - Configure UI
    func configureUI(img: UIImage?) {
        view.configureUI(img: img)
        addSubview(view)
        view.frame = CGRect(x: 7, y: 7, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
    }


}
