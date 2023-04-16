import UIKit


final class PersonalViewController: UIViewController  {
    static var userInfo: UserInfo.ViewModel = UserInfo.ViewModel()
    private lazy var personalView = PersonalInfoView()
    private lazy var cookedRecipes = PersonalContainerView()
    private lazy var favorite = PersonalContainerView()
    private lazy var rewards = PersonalContainerView()
    

    private let settings = UIImageView(image: UIImage(systemName: "pencil"))
    
    private enum Constants {
        static let settingsSize: CGFloat = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        configureUI()
        setupValues()
    }
    
    private let router: PersonalRoutingLogic
    private let interactor: PersonalBusinessLogic
    
    
    init(
        router: PersonalRoutingLogic,
        interactor: PersonalBusinessLogic,
        data: RegistrationInfo.ViewModel
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        PersonalViewController.userInfo = UserInfo.ViewModel(personalInfo: data)
        PersonalViewController.userInfo.rewards.append(RewardInfo.ViewModel(rewardText: "First recipe", rewardImage: "reward_first_recipe"))
        interactor.loadUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    func editTapped(_ sender: UITapGestureRecognizer) {
        router.routeToChangePersonalInfpScreen(interactor: interactor)
    }
    
    @objc
    func favoriteTapped(_ sender: UITapGestureRecognizer) {
        router.routeToFavoriteRecilesScreen(data: PersonalViewController.userInfo.favoriteRecipes)
    }
    
    @objc
    func cookesRecipesTapped(_ sender: UITapGestureRecognizer) {
        router.routeToCookedRecipesScreen(data: PersonalViewController.userInfo.cookedRecipes)
    }
    
    @objc
    func rewardsTapped(_ sender: UITapGestureRecognizer) {
        router.routeToRewards(interactor: interactor)
//        router.routeToNutritionScreen(data: "1")
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        setupValues()
//        super.viewWillAppear(animated)
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        super.viewWillDisappear(animated)
//    }
    
    static func changePersonalInfo(data: RegistrationInfo.Request) {
        userInfo.personalInfo.age = data.age
        userInfo.personalInfo.name = data.name
        userInfo.personalInfo.sex = data.sex
        
    }
    
    func setupValues() {
        personalView.configure(data: PersonalViewController.userInfo.personalInfo)
        cookedRecipes.configure(text: "Your cookbook", count: PersonalViewController.userInfo.cookedRecipes.count)
        favorite.configure(text: "Favorite", count: PersonalViewController.userInfo.favoriteRecipes.count)
        rewards.configure(text: "Rewards", count: PersonalViewController.userInfo.rewards.count)
    }
    
    func configureUI() {
        view.addSubview(personalView)
        view.addSubview(cookedRecipes)
        view.addSubview(favorite)
        view.addSubview(rewards)
        view.addSubview(settings)
        
        cookedRecipes.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(cookesRecipesTapped(_:))))
        favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(favoriteTapped(_:))))
        rewards.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(rewardsTapped(_:))))
        settings.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editTapped(_:))))
        
        settings.isUserInteractionEnabled = true
        cookedRecipes.isUserInteractionEnabled = true
        favorite.isUserInteractionEnabled = true
        rewards.isUserInteractionEnabled = true
        
        personalView.backgroundColor = .secondarySystemBackground
        cookedRecipes.backgroundColor = .secondarySystemBackground
        favorite.backgroundColor = .secondarySystemBackground
        rewards.backgroundColor = .secondarySystemBackground
        
        personalView.translatesAutoresizingMaskIntoConstraints = false
        cookedRecipes.translatesAutoresizingMaskIntoConstraints = false
        favorite.translatesAutoresizingMaskIntoConstraints = false
        rewards.translatesAutoresizingMaskIntoConstraints = false
        settings.translatesAutoresizingMaskIntoConstraints = false

        settings.tintColor = .label
        
        NSLayoutConstraint.activate([
            personalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            personalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personalView.heightAnchor.constraint(equalToConstant: personalView.intrinsicContentSize.height),
            
            
            
            settings.topAnchor.constraint(equalTo: personalView.topAnchor, constant: 10),
            settings.trailingAnchor.constraint(equalTo: personalView.trailingAnchor, constant: -14),
            settings.heightAnchor.constraint(equalToConstant: Constants.settingsSize),
            settings.widthAnchor.constraint(equalToConstant: Constants.settingsSize),
            
            cookedRecipes.topAnchor.constraint(equalTo: personalView.bottomAnchor, constant: 30),
            cookedRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookedRecipes.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cookedRecipes.heightAnchor.constraint(equalToConstant: cookedRecipes.intrinsicContentSize.height),
        
            favorite.topAnchor.constraint(equalTo: cookedRecipes.bottomAnchor, constant: 15),
            favorite.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favorite.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favorite.heightAnchor.constraint(equalToConstant: favorite.intrinsicContentSize.height),
            
            rewards.topAnchor.constraint(equalTo: favorite.bottomAnchor, constant: 15),
            rewards.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rewards.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rewards.heightAnchor.constraint(equalToConstant: rewards.intrinsicContentSize.height),
        ])
    }
}
extension PersonalViewController: PersonalDisplayLogic {
    func updatePersonalData() {
        personalView.configure(data: PersonalViewController.userInfo.personalInfo)
    }
}
