import UIKit


final class PersonalViewController: UIViewController  {
    static var userInfo: UserInfo.ViewModel = UserInfo.ViewModel()
    private lazy var personalView = PersonalInfoView()
    private lazy var cookedRecipes = PersonalContainerView()
    private lazy var favorite = PersonalContainerView()
    private lazy var rewards = PersonalContainerView()
    private let imgView = UIImageView(image: UIImage(named: "reward_first_recipe"))
    private let titleReward = UILabel()
    private let settings = UIImageView(image: UIImage(systemName: "pencil"))
    
    private enum Constants {
        static let settingsSize: CGFloat = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        interactor.loadUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    func editTapped(_ sender: UITapGestureRecognizer) {
        router.routeToChangePersonalInfpScreen(interactor: interactor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        setupValues()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
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
        view.addSubview(imgView)
        view.addSubview(titleReward)
        view.addSubview(settings)
        
        settings.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editTapped(_:))))
        settings.isUserInteractionEnabled = true
        personalView.backgroundColor = .secondarySystemBackground
        cookedRecipes.backgroundColor = .secondarySystemBackground
        favorite.backgroundColor = .secondarySystemBackground
        rewards.backgroundColor = .secondarySystemBackground
        
        personalView.translatesAutoresizingMaskIntoConstraints = false
        cookedRecipes.translatesAutoresizingMaskIntoConstraints = false
        favorite.translatesAutoresizingMaskIntoConstraints = false
        rewards.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleReward.translatesAutoresizingMaskIntoConstraints = false
        settings.translatesAutoresizingMaskIntoConstraints = false
        
        titleReward.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleReward.textAlignment = .left
        titleReward.textColor = .systemGray
        titleReward.text = "First recipe"
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
            
            
            imgView.topAnchor.constraint(equalTo: rewards.bottomAnchor, constant: 15),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imgView.widthAnchor.constraint(equalToConstant: 60),
            imgView.heightAnchor.constraint(equalToConstant: 60),
            
            titleReward.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5),
            titleReward.centerXAnchor.constraint(equalTo: imgView.centerXAnchor),
            titleReward.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
}
extension PersonalViewController: PersonalDisplayLogic {
    func updatePersonalData() {
        personalView.configure(data: PersonalViewController.userInfo.personalInfo)
    }
}
