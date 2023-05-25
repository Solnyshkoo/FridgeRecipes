import UIKit

final class RewardViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let sidesOffset: CGFloat = 15
    }

    // MARK: - Fields UI

    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    private let rewardsCell = (0 ... (PersonalViewController.userInfo.rewards.count == 0 ? 0 : PersonalViewController.userInfo.rewards.count - 1 ) 
                                     ).map { _ in RewardCell(frame: .zero) }

    // MARK: - Fields

    private let interactor: PersonalBusinessLogic
    private let rewards = PersonalViewController.userInfo.rewards

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        view.backgroundColor = .systemBackground
    }

    // MARK: - Init

    init(
        interactor: PersonalBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Config UI

    private func configUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let sectionsInRow = Int(UIScreen.main.bounds.width / 100)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])

        let allViews = stackView.subviews
        for item in allViews {
            stackView.removeArrangedSubview(item)
        }

        var count = 0

        rewardsCell.forEach { item in
            if rewards.count > count {
                item.configure(data: rewards[count])
                
                count += 1
                stackView.addSubview(item)
            }
        }

        count = 0
        var offsetHeight: CGFloat = 0
        var offsetWidth: CGFloat = 10

        for item in stackView.subviews {
            if count % sectionsInRow == 0, count != 0 {
                offsetHeight += item.intrinsicContentSize.height
                offsetWidth = 10
            }
            item.frame = CGRect(
                x: offsetWidth,
                y: offsetHeight,
                width: item.intrinsicContentSize.width,
                height: item.intrinsicContentSize.height
            )

            offsetWidth = item.intrinsicContentSize.width
            count += 1
        }
    }
}
