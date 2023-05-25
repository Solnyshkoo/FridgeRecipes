import UIKit

final class LoadingSplashScreen: UIView {
    // MARK: - Constants

    private enum Constants {
        static let loadingScreenAppearanceDuration: TimeInterval = 0.5
    }

    // MARK: - Fields

    private let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private let loadingView = UIActivityIndicatorView(style: .large)

    init(isHidden: Bool) {
        super.init(frame: .zero)

        blur.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        loadingView.startAnimating()
        blur.contentView.addSubview(loadingView)
        addSubview(blur)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        layer.opacity = isHidden ? 0 : 1
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout subviews

    override func layoutSubviews() {
        super.layoutSubviews()
        blur.frame = bounds
    }

    func setAppearance(shouldHide: Bool, animated: Bool) {
        guard animated else {
            isHidden = shouldHide
            return
        }

        if shouldHide {
            UIView.animate(withDuration: Constants.loadingScreenAppearanceDuration, animations: {
                self.layer.opacity = 0
            }, completion: { _ in
                self.isHidden = true
            })
            return
        }
        layer.opacity = 0
        isHidden = false
        UIView.animate(withDuration: Constants.loadingScreenAppearanceDuration, animations: {
            self.layer.opacity = 1
        })
    }
}
