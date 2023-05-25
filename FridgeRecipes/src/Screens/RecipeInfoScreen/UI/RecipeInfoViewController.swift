import UIKit

final class RecipeInfoViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let heartSize = CGSize(width: 35, height: 35)
        static let defaultEmoji: String = "😋"
    }

    // MARK: - Fields UI

    private lazy var scrollView = factory.makeScrollView()
    private lazy var contentStackView = factory.makeContentStackView()
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

    // MARK: - Fields

    private let router: RecipeInfoRoutingLogic
    private let interactor: RecipeInfoBusinessLogic
    private let factory = RecipeInfoFactory()
    private var previousStatusBarHidden = false
    private var recipeInfo: RecipeInfo = .init()

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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreenAppearance(shouldHide: false, animated: false)

        mealImageView.image = nil
        scrollView.refreshControl = refreshControl

        view.backgroundColor = .systemBackground
        setTranslatingToConstraints()
        addSubviews()
        setScrollView()
        configureImageContainer()
        configureMealImage()
        configureButtons()
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

    // MARK: - Action: add or delete recipe from favorite

    @objc
    private func updateLike(_ sender: LikeButton) {
        if sender.isLiked {
            let index = PersonalViewController.userInfo.favoriteRecipes.firstIndex { item in
                item.id == recipeInfo.id
            }
            guard let index = index else {
                return
            }
            PersonalViewController.userInfo.favoriteRecipes.remove(at: index)
            interactor.deleteFav(id: recipeInfo.id ?? "")
        } else {
            PersonalViewController.userInfo.favoriteRecipes.append(
                MainModel.Recipe.ViewModel(
                    id: recipeInfo.id ?? "",
                    titleText: recipeInfo.name,
                    thumbnailLink: recipeInfo.thumbnailLink
                )
            )

            interactor.saveFav(data: MainModel.Recipe.ViewModel(
                id: recipeInfo.id ?? "",
                titleText: recipeInfo.name,
                thumbnailLink: recipeInfo.thumbnailLink
            ))
        }
        sender.isLiked = !sender.isLiked
    }

    // MARK: - Action: add or delete recipe from cooked

    @objc
    private func updateCooked(_ sender: CookedButton) {
        if sender.isCooked {
            let index = PersonalViewController.userInfo.cookedRecipes.firstIndex { item in
                item.id == recipeInfo.id
            }
            guard let index = index else {
                return
            }
            PersonalViewController.userInfo.cookedRecipes.remove(at: index)
            interactor.deleteCooked(id: recipeInfo.id ?? "")
        } else {
            PersonalViewController.userInfo.cookedRecipes.append(
                MainModel.Recipe.ViewModel(
                    id: recipeInfo.id ?? "",
                    titleText: recipeInfo.name,
                    thumbnailLink: recipeInfo.thumbnailLink
                )
            )
            interactor.saveCooked(data: MainModel.Recipe.ViewModel(
                id: recipeInfo.id ?? "",
                titleText: recipeInfo.name,
                thumbnailLink: recipeInfo.thumbnailLink
            ))
        }

        if PersonalViewController.userInfo.rewards.isEmpty {
            PersonalViewController.userInfo.rewards.append(RewardInfo.ViewModel(rewardText: "First recipe", rewardImage: "reward_first_recipe"))
            showSimpleAlert()
            interactor.saveReward(data: RewardInfo.ViewModel(rewardText: "First recipe", rewardImage: "reward_first_recipe"))
        }
        sender.isCooked = !sender.isCooked
    }

    // MARK: - Action: close screen

    @objc
    private func close() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Get recipe info

    func getData(data: String) {
        interactor.loadRecipe(RecipeInfoModel.Start.Request(id: data))
    }

    // MARK: - Changing appearance

    private func setLoadingScreenAppearance(shouldHide: Bool, animated: Bool) {
        loadingScreen.setAppearance(shouldHide: shouldHide, animated: animated)
    }

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
        interactor.loadNutrition(recipeInfo.ingredients)
    }

    private func clearIngredientsStack() {
        for subview in ingredientStack.arrangedSubviews where !(subview is UILabel) {
            ingredientStack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    func showSimpleAlert() {
        let alert = UIAlertController(
            title: "Сongratulations",
            message: "You have received a reward! Now it is available in your personal account.",
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Configuring views

    private func setTranslatingToConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        ingredientStack.translatesAutoresizingMaskIntoConstraints = false
        recipeStack.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(loadingScreen)
        titleView.addArrangedSubview(titleLabel)
        titleView.addArrangedSubview(cookedButton)
        titleView.addArrangedSubview(likeButton)
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

    private func updateButtons() {
        let k = PersonalViewController.userInfo.favoriteRecipes.contains(where: { item in
            item.id == recipeInfo.id
        })
        likeButton.isLiked = k

        cookedButton.isCooked = PersonalViewController.userInfo.cookedRecipes.contains(where: { item in
            item.id == recipeInfo.id
        })
    }

    private func configureLoadingScreen() {
        NSLayoutConstraint.activate([
            loadingScreen.topAnchor.constraint(equalTo: view.topAnchor),
            loadingScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UIScrollViewDelegate

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
    func openNutritionInfo(data: [String]) {
        router.routeToNutritionScreen(data: data)
    }

    func displayRecipe(_ viewModel: RecipeInfo) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            if let url = viewModel.thumbnailLink {
                self.interactor.getImage(url: url)
            }
            self.recipeInfo = viewModel
            self.updateButtons()
            self.likeButton.isHidden = false

            self.cookedButton.isHidden = false
            
            self.titleLabel.text = viewModel.name
            if let ingredients = viewModel.ingredients, !ingredients.isEmpty {
                self.ingredientStack.isHidden = false
                self.fillIngredients(viewModel.ingredients)
            } else { self.ingredientStack.isHidden = true }
            if let recipe = viewModel.instructions, !recipe.isEmpty {
                self.recipeStack.isHidden = false
                self.recipeLabel.text = recipe
            } else { self.recipeStack.isHidden = true }
        }
    }
    
    func setImage(data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mealImageView.image = UIImage(data: data)
        }
    }

//    func loadImage(url: URL) -> UIImage? {
//
//        interactor.getImage(from: url) { data in
//            <#code#>
//        }
//        return UIImage(data: interactor.getImage(url: url))
//
////        guard let data = try? Data(contentsOf: url) else { return nil }
////        return UIImage(data: data)
//    }
}
