import UIKit

final class NutritionViewController: UIViewController {
    
    private let interactor: NutritionBusinessLogic
    private let factory = NutritionFactory()
    
    private lazy var scrollView = UIScrollView()
    private let caloriesInfo = CaloriesView()
    private lazy var mainTitle = factory.makeTittleLabel()
    private lazy var bigSeparator = factory.makeSeparaator()
    private lazy var smallSeparator = factory.makeSeparaator()
    private lazy var separator = factory.makeSeparaator()
    private lazy var amountInfo = factory.makeDiscriptionLabel()
    private lazy var dailyValueLabel = factory.makeSubtitleLabel()
    private let mainInfo = NutritionMainInfoView()
    private let info = NutritionInfoView()
    
    init(interactor: NutritionBusinessLogic, data: String) {
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

    
    private enum Constants {
        static let sidesOffset: CGFloat = 15
    }
    
    
    private func configUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(bigSeparator)
        scrollView.addSubview(amountInfo)
        scrollView.addSubview(caloriesInfo)
        scrollView.addSubview(smallSeparator)
        scrollView.addSubview(separator)
        scrollView.addSubview(mainInfo)
        scrollView.addSubview(info)
        scrollView.addSubview(dailyValueLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        caloriesInfo.translatesAutoresizingMaskIntoConstraints = false
        mainInfo.translatesAutoresizingMaskIntoConstraints = false
        info.translatesAutoresizingMaskIntoConstraints = false
        dailyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        caloriesInfo.config(count: "1234")
        mainInfo.config(title: "axascw", amount: "3,4CD", percentage: "56")
        info.config(title: "axascw", amount: "3,4CD", percentage: "56")
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 33),

            bigSeparator.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 15),
            bigSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            bigSeparator.widthAnchor.constraint(equalToConstant: view.bounds.width - 2 * Constants.sidesOffset),
            bigSeparator.heightAnchor.constraint(equalToConstant: 10),

            amountInfo.topAnchor.constraint(equalTo: bigSeparator.bottomAnchor, constant: 15),
            amountInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            amountInfo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.sidesOffset),
            amountInfo.heightAnchor.constraint(equalToConstant: amountInfo.intrinsicContentSize.height),

            caloriesInfo.topAnchor.constraint(equalTo: amountInfo.bottomAnchor, constant: 15),
            caloriesInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            caloriesInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            caloriesInfo.heightAnchor.constraint(equalToConstant: caloriesInfo.intrinsicContentSize.height),

            smallSeparator.topAnchor.constraint(equalTo: caloriesInfo.bottomAnchor, constant: 15),
            smallSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            smallSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            smallSeparator.heightAnchor.constraint(equalToConstant: 5),

            dailyValueLabel.topAnchor.constraint(equalTo: smallSeparator.bottomAnchor, constant: 2.5),
            dailyValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            dailyValueLabel.heightAnchor.constraint(equalToConstant: 15),
            
            separator.topAnchor.constraint(equalTo: smallSeparator.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            mainInfo.topAnchor.constraint(equalTo: separator.bottomAnchor),
            mainInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            mainInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            mainInfo.heightAnchor.constraint(equalToConstant: mainInfo.intrinsicContentSize.height),
            
            info.topAnchor.constraint(equalTo: mainInfo.bottomAnchor),
            info.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            info.heightAnchor.constraint(equalToConstant: mainInfo.intrinsicContentSize.height),
    
        ])

    }
    
}

extension NutritionViewController: NutritionDisplayLogic {
    func displayRecipe(_ viewModel: Model.ViewModel) {
    }
    
    
}
