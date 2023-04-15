import UIKit

final class NutritionViewController: UIViewController {
    
    private let interactor: NutritionBusinessLogic
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nil, bundle: nil)
//
//        self.modalPresentationStyle = .pageSheet
//
//        self.isModalInPresentation = false
//    }
    private let imgView = UIImageView(image: UIImage(named: "reward_first_recipe"))
    private let titleReward = UILabel()
    
//    private lazy var image = UIImageView()
    
    init(interactor: NutritionBusinessLogic, data: String) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
        configUI()
    }
    
    func configUI() {
//        image.image = UIImage(named: "Nutrition")
//        image.layer.masksToBounds = true
//        image.contentMode = .scaleToFill
//        view.addSubview(image)
//        image.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
//            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//        ])
        
        view.addSubview(imgView)
        view.addSubview(titleReward)
        
//        personalView.backgroundColor = .secondarySystemBackground
//        cookedRecipes.backgroundColor = .secondarySystemBackground
//        favorite.backgroundColor = .secondarySystemBackground
//        rewards.backgroundColor = .secondarySystemBackground
//
//        personalView.translatesAutoresizingMaskIntoConstraints = false
//        cookedRecipes.translatesAutoresizingMaskIntoConstraints = false
//        favorite.translatesAutoresizingMaskIntoConstraints = false
//        rewards.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleReward.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleReward.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleReward.textAlignment = .left
        titleReward.textColor = .systemGray
        titleReward.text = "First recipe"
        
        NSLayoutConstraint.activate([
//            personalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            personalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            personalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            personalView.heightAnchor.constraint(equalToConstant: personalView.intrinsicContentSize.height),
//
//            cookedRecipes.topAnchor.constraint(equalTo: personalView.bottomAnchor, constant: 30),
//            cookedRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cookedRecipes.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cookedRecipes.heightAnchor.constraint(equalToConstant: cookedRecipes.intrinsicContentSize.height),
//
//            favorite.topAnchor.constraint(equalTo: cookedRecipes.bottomAnchor, constant: 15),
//            favorite.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            favorite.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            favorite.heightAnchor.constraint(equalToConstant: favorite.intrinsicContentSize.height),
//
//            rewards.topAnchor.constraint(equalTo: favorite.bottomAnchor, constant: 15),
//            rewards.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            rewards.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            rewards.heightAnchor.constraint(equalToConstant: rewards.intrinsicContentSize.height),
            
            
            imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imgView.widthAnchor.constraint(equalToConstant: 60),
            imgView.heightAnchor.constraint(equalToConstant: 60),
            
            titleReward.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5),
            titleReward.centerXAnchor.constraint(equalTo: imgView.centerXAnchor),
            titleReward.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
}

extension NutritionViewController: NutritionDisplayLogic {
    func displayRecipe(_ viewModel: Model.Start.ViewModel) {
    }
    
    
}
