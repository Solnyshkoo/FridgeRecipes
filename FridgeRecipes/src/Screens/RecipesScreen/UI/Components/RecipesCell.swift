import UIKit

final class RecipesCell: UITableViewCell {
    static let cellID = "recipesCell"

    // MARK: - Constants

    private enum Constants {
        static let titleFontSize: CGFloat = 18
        static let cornerRadius: CGFloat = 20
        static let imCornRadius: CGFloat = 15
        static let labelGap: CGFloat = 10
        static let imageGap: CGFloat = 10
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 3
        static let shadowColor: CGColor = UIColor.black.cgColor
        static let shadowOffset = CGSize(width: 0.0, height: 5.0)
        static let height: CGFloat = 150
    }

    // MARK: - Fields

    private var animator: UIViewPropertyAnimator?
    private lazy var cellStack = makeStackView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var imgView = makeImageView()
    private lazy var containerView = makeContainerView()
    private lazy var shadowLayer = makeShadowLayer()
    private lazy var indicator = makeActivityIndicator()

    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellStack)
        cellStack.addSubview(titleLabel)
        cellStack.addSubview(imgView)
        cellStack.addSubview(indicator)
        contentView.clipsToBounds = true
        configureStackView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.insertSublayer(shadowLayer, at: 0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        animator?.stopAnimation(true)
    }

    // MARK: - configure

    func configure(
        data: MainModel.Recipe.ViewModel,
        animate: Bool = true
    ) {
        titleLabel.text = data.titleText

        guard let link = data.thumbnailLink else {
            return
        }
        guard let img = loadImage(url: link) else {
            return
        }

        if animate {
            showImage(image: img)
        } else {
            imgView.image = img
        }
    }

    func configureStackView() {
        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Make UI elements

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .cellBackgroundColor
        stackView.layer.cornerRadius = Constants.cornerRadius
        return stackView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel(
            frame: CGRect(
                x: contentView.frame.width / 2 + Constants.labelGap, y: 0,
                width: contentView.frame.width / 2 - 2 * Constants.labelGap,
                height: Constants.height
            )
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }

    private func makeImageView() -> UIImageView {
        let image = UIImageView(
            frame: CGRect(
                x: Constants.imageGap, y: Constants.imageGap,
                width: contentView.frame.width / 2 - 2 * Constants.imageGap,
                height: Constants.height - 2 * Constants.imageGap
            )
        )
        image.backgroundColor = .systemFill
        image.layer.cornerRadius = Constants.imCornRadius
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }

    func makeContainerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func makeShadowLayer() -> CAShapeLayer {
        shadowLayer = CAShapeLayer()

        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius)
            .cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = Constants.shadowColor
        shadowLayer.shadowOffset = Constants.shadowOffset
        shadowLayer.shadowOpacity = Constants.shadowOpacity
        shadowLayer.shadowRadius = Constants.shadowRadius

        return shadowLayer
    }

    func makeActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = CGPoint(
            x: 0.75 * contentView.frame.width,
            y: Constants.height / 2
        )
        return indicator
    }

    // MARK: - Picture

    private func showImage(image: UIImage?) {
        imgView.alpha = 0.0
        animator?.stopAnimation(false)
        imgView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.imgView.alpha = 1.0
            }
        )
    }

    func loadImage(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}
