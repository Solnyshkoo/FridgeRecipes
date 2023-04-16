import UIKit

final class RewardViewController: UIViewController {
    
    private enum Constants {
        static let sidesOffset: CGFloat = 15
    }
    
    private let interactor: PersonalBusinessLogic
    private let rewards = PersonalViewController.userInfo.rewards
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    init(
        interactor: PersonalBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.view.backgroundColor = .systemBackground
//        scrollView.scrollIndicatorInsets = view.safeAreaInsets
    }
    private let rewardsCell = (0 ...  PersonalViewController.userInfo.rewards.count - 1).map { _ in RewardCell(frame: .zero) }
    
    private func configUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(
//            RewardCell.self,
//            forCellWithReuseIdentifier: RewardCell.cellId
//        )
//
//        collectionView.backgroundColor = .clear
        
        let sectionsInRow = Int(UIScreen.main.bounds.width / 100)
//        let rows = rewards.count / sectionsInRow
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
            item.configure(data: rewards[count])

            count += 1
            stackView.addSubview(item)
        }
        
        count = 0
        var offsetHeight: CGFloat = 0
        var offsetWidth: CGFloat = 10
        
        for item in stackView.subviews {
            if count % sectionsInRow == 0 && count != 0 {
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
    
//    func makeCollectionView() -> UICollectionView {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        collectionView.collectionViewLayout = layout
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.contentInset = Constants.sideInsets
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        return cv
//    }
    
}
//
//extension RewardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        Int(UIScreen.main.bounds.width / 100)
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        rewards.count / Int(UIScreen.main.bounds.width / 100)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RewardCell.cellId, for: indexPath)
//        guard let rewardCell = cell as? RewardCell else { return cell }
//        let rewardInfo = rewards[indexPath.row]
//        rewardCell.configure(data: rewardInfo)
//        return rewardCell
//    }
//}
