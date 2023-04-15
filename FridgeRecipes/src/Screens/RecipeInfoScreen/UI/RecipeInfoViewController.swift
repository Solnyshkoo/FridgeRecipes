import UIKit

final class RecipeInfoViewController: UIViewController {
    private enum Constants {
        static let heartSize = CGSize(width: 35, height: 35)
//        static let closeButtonSize = CGSize(width: 40, height: 40)
//        static let closeButtonTopMargin: CGFloat = 16
//        static let closeButtonRightMargin: CGFloat = -16
        static let defaultEmoji: String = "😋"
//        static let loadingScreenAppearanceDuration: TimeInterval = 0.5
    }
    // MARK: - Fields
    private let router: RecipeInfoRoutingLogic
    private let interactor: RecipeInfoBusinessLogic
    private let factory = RecipeInfoFactory()
    
    private lazy var scrollView = factory.makeScrollView()
    private lazy var contentStackView = factory.makeContentStackView()
    
//    private lazy var roundCornerButton = factory.makeRoundButtonWithBlur(
//        type: .refresh
//    )
    private lazy var mealImageView = factory.makeMealImageView()
    private lazy var titleView = factory.makeTitleView()
    private lazy var titleLabel = factory.makeTitleLabel()
    private lazy var likeButton = factory.makeLikeButton()
    private lazy var cookedButton = factory.makeCookedButton()
    private lazy var ingredientStack = factory.makeIngredientsStack()
    private lazy var ingredientsLabel = factory.makeRecipeLabel()
    private lazy var recipeStack = factory.makeRecipeStack()
    private lazy var recipeLabel = factory.makeRecipeLabel()
    private lazy var textStackView = factory.makeTextStackView()
    private lazy var loadingScreen = factory.makeLoadingScreen(isHidden: true)
    private lazy var nutritionButton = factory.makeNutritionsTitle()
    private let imageContainerView = UIView()
    
    private let refreshControl = UIRefreshControl()

    // используется в extension UIScrollViewDelegate
    private var previousStatusBarHidden = false
    
    // MARK: - LifeCycle
    init(
        router: RecipeInfoRoutingLogic,
        interactor: RecipeInfoBusinessLogic,
        data: String
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        getData(data: data)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // putting data
//        loadMealData()

        // configuring views
//        if preloadedMeal == nil {
            setLoadingScreenAppearance(shouldHide: false, animated: false)
//            refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        self.mealImageView.image = nil
            scrollView.refreshControl = refreshControl
//        }
        view.backgroundColor = .systemBackground
        setTranslatingToConstraints()
        addSubviews()
        setScrollView()
        configureImageContainer()
        configureMealImage()
        configureButtons()
//        configureCloseButton()
        configureTextStackView()
        configureLoadingScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // executes when like button is pressed
    @objc private func updateLike(_ sender: LikeButton) {
        sender.isLiked = !sender.isLiked
//        if preloadedMeal != nil {
//            preloadedMeal!.isLiked = sender.isLiked
//        } else if randomMeal != nil {
//            randomMeal!.isLiked = sender.isLiked
//        }
    }
    @objc private func updateCooked(_ sender: CookedButton) {
        sender.isCooked = !sender.isCooked
//        if preloadedMeal != nil {
//            preloadedMeal!.isLiked = sender.isLiked
//        } else if randomMeal != nil {
//            randomMeal!.isLiked = sender.isLiked
//        }
    }
    // executes when close button is pressed
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

    
    func getData(data: String) {
        interactor.loadRecipe(RecipeInfoModel.Start.Request(id: data))
    }
    
    // MARK: - changing appearance

    private func setLoadingScreenAppearance(shouldHide: Bool, animated: Bool) {
        loadingScreen.setAppearance(shouldHide: shouldHide, animated: animated)
    }

//    private func loadImage(link: String) {
//        cancellable = imageLoader.loadImage(thumbnailLink: link).sink { [weak self] image in
//            self?.mealImageView.image = image
//        }
//    }

    private func fillIngredients(_ ingredients: [Ingredient]?, drinks: Bool = false) {
        guard let ingredients = ingredients else { return }
        clearIngredientsStack()
        for ingredient in ingredients {
            let ingredientCell = factory.makeIngredientCell(
                name: ingredient.name,
                measure: ingredient.measure ?? "",
                drinks: drinks
            )
            ingredientStack.addArrangedSubview(ingredientCell)
        }
        nutritionButton.addTarget(self, action: #selector(showNutritionInfo(sender:)), for: .touchUpInside)
        ingredientStack.addArrangedSubview(nutritionButton)
    }

    @objc
    private func showNutritionInfo(sender: UIButton) {
        router.routeToNutritionScreen(data: "String")
    }

    private func clearIngredientsStack() {
        for subview in ingredientStack.arrangedSubviews where !(subview is UILabel) {
            ingredientStack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    // MARK: - configuring view funcs

    private func setTranslatingToConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        ingredientStack.translatesAutoresizingMaskIntoConstraints = false
        recipeStack.translatesAutoresizingMaskIntoConstraints = false
//        roundCornerButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        view.addSubview(scrollView)
//        view.addSubview(roundCornerButton)
        view.addSubview(loadingScreen)
        titleView.addArrangedSubview(titleLabel)
        titleView.addArrangedSubview(cookedButton)
        titleView.addArrangedSubview(likeButton)
//        
//        titleView.addSubview(titleLabel)
//        titleView.addSubview(cookedButton)
//        titleView.addSubview(likeButton)
//        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        cookedButton.translatesAutoresizingMaskIntoConstraints = false
//        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: titleView.intrinsicContentSize.width),
//
//            likeButton.topAnchor.constraint(equalTo: titleView.topAnchor),
//            likeButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
//            likeButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -likeButton.intrinsicContentSize.width),
//
//            cookedButton.topAnchor.constraint(equalTo: titleView.topAnchor),
//            cookedButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
//            cookedButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -10),
//        ])
        
        ingredientStack.addArrangedSubview(ingredientsLabel)
        recipeStack.addArrangedSubview(recipeLabel)
        scrollView.addSubview(imageContainerView)
        scrollView.addSubview(mealImageView)
        scrollView.addSubview(textStackView)
        textStackView.addArrangedSubview(titleView)
        textStackView.addArrangedSubview(ingredientStack)
        textStackView.addArrangedSubview(recipeStack)
    }

    private func setScrollView() {
        scrollView.delegate = self
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func configureImageContainer() {
        let imageRatio: CGFloat = 0.75
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainerView.heightAnchor.constraint(
                equalTo: imageContainerView.widthAnchor,
                multiplier: imageRatio
            ),
        ])
    }

    private func configureMealImage() {
        mealImageView.contentMode = .scaleAspectFill
        mealImageView.clipsToBounds = true

        let mealImageTopConstraint = mealImageView.topAnchor.constraint(equalTo: view.topAnchor)
        mealImageTopConstraint.priority = .defaultHigh

        let mealImageHeightConstraint = mealImageView.heightAnchor
            .constraint(greaterThanOrEqualTo: imageContainerView.heightAnchor)
        mealImageHeightConstraint.priority = .required

        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            mealImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            mealImageTopConstraint, mealImageHeightConstraint,
        ])
    }

    private func configureTextStackView() {
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
            textStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            textStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    private func configureButtons() {
        likeButton.addTarget(self, action: #selector(updateLike), for: .touchUpInside)
        cookedButton.addTarget(self, action: #selector(updateCooked), for: .touchUpInside)
    }

//    private func configureCloseButton() {
//        if preloadedMeal == nil {
//            roundCornerButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
//        } else {
//            roundCornerButton.addTarget(self, action: #selector(close), for: .touchUpInside)
//        }
//        NSLayoutConstraint.activate([
//            roundCornerButton.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor,
//                constant: Constants.closeButtonRightMargin
//            ),
//            roundCornerButton.topAnchor.constraint(
//                equalTo: view.layoutMarginsGuide.topAnchor,
//                constant: Constants.closeButtonTopMargin
//            ),
//            roundCornerButton.heightAnchor
//                .constraint(equalToConstant: Constants.closeButtonSize.height),
//            roundCornerButton.widthAnchor
//                .constraint(equalToConstant: Constants.closeButtonSize.width),
//        ])
//    }

    private func configureLoadingScreen() {
        NSLayoutConstraint.activate([
            loadingScreen.topAnchor.constraint(equalTo: view.topAnchor),
            loadingScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension RecipeInfoViewController: UIScrollViewDelegate {
    private var shouldHideStatusBar: Bool {
        let frame = titleLabel.convert(titleView.bounds, to: view)
        return frame.minY < view.safeAreaInsets.top
    }

    override var prefersStatusBarHidden: Bool {
        shouldHideStatusBar
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        .slide
    }

    func scrollViewDidScroll(_: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
}
// MARK: - Protocol DisplayLogic
extension RecipeInfoViewController: RecipeInfoDisplayLogic {
    func displayRecipe(_ viewModel: RecipeInfo) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.likeButton.isHidden = false

            self.cookedButton.isHidden = false
            if let link = viewModel.thumbnailLink {
                self.mealImageView.image = self.loadImage(url: link)
            }
            self.titleLabel.text = viewModel.name
            if let ingredients = viewModel.ingredients, !ingredients.isEmpty {
                self.ingredientStack.isHidden = false
                self.fillIngredients(viewModel.ingredients)
            } else { self.ingredientStack.isHidden = true }
            if let recipe = viewModel.instructions, !recipe.isEmpty {
                self.recipeStack.isHidden = false
                self.recipeLabel.text = recipe
            } else { self.recipeStack.isHidden = true }
//        likeButton.isLiked = meal.isLiked
        }
    }
    
    // FIXME: - Убрать от сюда
    func loadImage(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else {return nil}
        return UIImage(data: data)
    }
}