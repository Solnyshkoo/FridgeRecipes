import UIKit

final class MainViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
        static let blurAnimationDuration: TimeInterval = 0.5
        static let ingredientHeight: CGFloat = 35
        static let sideInsetValue: CGFloat = 16
        static let ingredientCellType = IngredientSuggestionCell.self
        static let ingredientCellID = IngredientSuggestionCell.cellID
    }

    // MARK: - UI Fields
    private lazy var searchBar: UISearchBar = factory.makeSearchBar()
    private lazy var resultCollectionView: UICollectionView = factory.makeResultCollectionView()
    private lazy var suggestionScrollView = factory.makeScrollView()
    private lazy var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private lazy var ingredientCollectionView: UICollectionView = factory.makeIngredientCollectionView()
    private lazy var ingredientSuggestionsStack: UIStackView = factory.makeIngredientSuggestionStackView()
    private lazy var ingredientSuggestionTitle: UILabel = factory.makeIngredientSuggestionTitle()
    private lazy var suggestionStackView: UIStackView = factory.makeSuggestionStackView()
    private lazy var categoriesScrollView = factory.makeScrollView()
    private lazy var storiesStackView = factory.makeStoriesStackView()
    private lazy var categoryStackView = factory.makeCategoryStackView()
    private lazy var cusineStackView = factory.makeCusineStackView()
    private var filters: String = ""
    
    private lazy var ingredientDataSource = IngredientDataSource(
        cellID: Constants.ingredientCellID,
        updateParentFilters: { [weak self] newFilters in
            guard let self = self else {
                return
            }

            self.router.routeToRecipesScreen(data: .mealsByIngredient(ingredient: newFilters), titleText: newFilters)
        }
    )
    
    // MARK: - Fields

    private let router: MainRoutingLogic
    private let interactor: MainBusinessLogic
    private let factory = MainScreenFactory()
    
    // MARK: - LifeCycle

    init(
        router: MainRoutingLogic,
        interactor: MainBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurView.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureSearchBar()
        configureResultCollectionView()

        configureStackView()
        configureScrollView()
        configureSuggestionsLayout()
        configureIngredientSuggestions()
        configureCollectionViewSources()
    }
    
    // MARK: - Set up all subviews

    private func addSubviews() {
        view.addSubview(blurView)
        view.addSubview(resultCollectionView)
        view.addSubview(searchBar)
        view.addSubview(suggestionScrollView)
        view.addSubview(categoriesScrollView)
        view.addSubview(categoryStackView)
        view.addSubview(cusineStackView)
        
        categoriesScrollView.addSubview(categoryStackView)
        categoriesScrollView.addSubview(cusineStackView)
        categoriesScrollView.addSubview(storiesStackView)
        
        suggestionScrollView.addSubview(suggestionStackView)
        suggestionStackView.addArrangedSubview(ingredientSuggestionsStack)
        
        ingredientSuggestionsStack.addArrangedSubview(ingredientSuggestionTitle)
        ingredientSuggestionsStack.addArrangedSubview(ingredientCollectionView)
    }
    
    // MARK: - CollectionView Sources

    private func configureCollectionViewSources() {
        ingredientCollectionView.dataSource = ingredientDataSource
        ingredientCollectionView.delegate = ingredientDataSource
        ingredientCollectionView.register(
            Constants.ingredientCellType,
            forCellWithReuseIdentifier: Constants.ingredientCellID
        )
    }

    // MARK: - UI SearchBar

    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: - CollectionView & ScrollView & StackView

    private func configureResultCollectionView() {
        resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            resultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureScrollView() {
        suggestionScrollView.translatesAutoresizingMaskIntoConstraints = false
        categoriesScrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            suggestionScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            suggestionScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            suggestionScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            suggestionScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoriesScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            categoriesScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            categoriesScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
 
        ])
        categoriesScrollView.backgroundColor = .systemBackground
        
        suggestionScrollView.layer.opacity = 0
        suggestionScrollView.layer.isHidden = true
    }
    
    @objc
    func openStories(_: UITapGestureRecognizer) {
        router.routeToStories()
    }
    
    private func configureStackView() {
        categoryStackView.config(deleg: self)
        cusineStackView.config(del: self)
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        let offset = (UIScreen.main.bounds.width - categoryStackView.intrinsicContentSize.width) / 2
        suggestionStackView.translatesAutoresizingMaskIntoConstraints = false
        storiesStackView.translatesAutoresizingMaskIntoConstraints = false
        cusineStackView.translatesAutoresizingMaskIntoConstraints = false
        
        storiesStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openStories(_:))))
        
        storiesStackView.isUserInteractionEnabled = true
        cusineStackView.isUserInteractionEnabled = true
        categoryStackView.isUserInteractionEnabled = true
        
        suggestionStackView.axis = .vertical
        suggestionStackView.distribution = .fill
        suggestionStackView.alignment = .fill

        NSLayoutConstraint.activate([
            suggestionStackView.topAnchor.constraint(equalTo: suggestionScrollView.topAnchor),
            suggestionStackView.leftAnchor.constraint(equalTo: suggestionScrollView.leftAnchor),
            suggestionStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            suggestionStackView.bottomAnchor.constraint(equalTo: suggestionScrollView.bottomAnchor),
            
            storiesStackView.topAnchor.constraint(equalTo: categoriesScrollView.topAnchor),
            storiesStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: offset),
            storiesStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -offset),
            storiesStackView.heightAnchor.constraint(equalToConstant: storiesStackView.intrinsicContentSize.height),
            
            categoryStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: offset),
            categoryStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -offset),
            categoryStackView.heightAnchor.constraint(equalToConstant: categoryStackView.intrinsicContentSize.height),
            categoryStackView.topAnchor.constraint(equalTo: storiesStackView.bottomAnchor, constant: 20),
            
            cusineStackView.bottomAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor),
            cusineStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: offset),
            cusineStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -offset),
            cusineStackView.heightAnchor.constraint(equalToConstant: cusineStackView.intrinsicContentSize.height),
            cusineStackView.topAnchor.constraint(equalTo: categoryStackView.bottomAnchor, constant: 20),
        ])
    }
    
    // MARK: - Ingredient Suggestions

    private func configureSuggestionsLayout() {
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(searchBar)
        view.bringSubviewToFront(suggestionScrollView)
        updateSuggestionLayout(isHidden: false)
        searchBar.becomeFirstResponder()
    }

    private func configureIngredientSuggestions() {
        ingredientCollectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            ingredientCollectionView.heightAnchor
                .constraint(equalToConstant: Constants.ingredientHeight),
            ingredientCollectionView.widthAnchor
                .constraint(equalTo: ingredientSuggestionsStack.widthAnchor),
        ])

        NSLayoutConstraint.activate([
            ingredientSuggestionTitle.leadingAnchor.constraint(
                equalTo: ingredientSuggestionsStack.leadingAnchor,
                constant: Constants.sideInsetValue
            ),
            ingredientSuggestionTitle.trailingAnchor.constraint(
                equalTo: ingredientSuggestionsStack.trailingAnchor,
                constant: -Constants.sideInsetValue
            ),
        ])
    }
    
    private func updateSuggestionLayout(isHidden: Bool) {
        searchBar.setShowsCancelButton(!isHidden, animated: true)
        switch isHidden {
        case true:
            searchBar.endEditing(true)
            UIView.animate(withDuration: Constants.blurAnimationDuration, animations: {
                self.blurView.layer.opacity = 0
                self.suggestionScrollView.layer.opacity = 0
            }, completion: { _ in
                self.blurView.isHidden = true
                self.suggestionScrollView.isHidden = true
            })
        case false:
            blurView.isHidden = false
            suggestionScrollView.isHidden = false
            UIView.animate(withDuration: Constants.blurAnimationDuration, animations: {
                self.blurView.layer.opacity = 1
                self.suggestionScrollView.layer.opacity = 1
            })
        }
    }
}

// MARK: - Protocol DisplayLogic

extension MainViewController: MainDisplayLogic {
    func displayRecipes(_ viewModel: MainModel.Recipe.Request) {
        router.routeToRecipesScreen(data: RequestType.mealsByName(name: viewModel.searchText), titleText: searchBar.nonOptionalText)
    }
}

// MARK: - UISearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_: UISearchBar) {
        displayRecipes(MainModel.Recipe.Request(searchText: searchBar.nonOptionalText, productsFilter: []))
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        updateSuggestionLayout(isHidden: true)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        updateSuggestionLayout(isHidden: false)
    }
}


// MARK: - CategoryStackViewProtocol, CusineStackViewProtocol
extension MainViewController: CategoryStackViewProtocol, CusineStackViewProtocol {
    func cusinePressed(name: String) {
        router.routeToRecipesScreen(data: RequestType.mealByCuisine(cuisine: name), titleText: name)
    }
    
    func wasPressed(name: String) {
        router.routeToRecipesScreen(data: RequestType.mealByCategory(category: name), titleText: name)
    }
}


