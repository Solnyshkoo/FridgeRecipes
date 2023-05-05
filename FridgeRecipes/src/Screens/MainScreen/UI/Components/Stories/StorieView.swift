import UIKit
final class StorieView: UIView {
    // MARK: - Fields

    private let imageView: UIImageView = .init(frame: .zero)
    private let width = (UIScreen.main.bounds.width - 50) / 3
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: 180)
    }
    
    // MARK: - Configure UI

    func configureUI(img: UIImage?) {
        imageView.image = img
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
    
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: 180)
    }
}
