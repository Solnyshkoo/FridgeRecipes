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
    private lazy var searchBar: UISearchBar = factory.makeSearchBar()
    private lazy var resultCollectionView: UICollectionView = factory.makeResultCollectionView()
    private lazy var suggestionScrollView = factory.makeScrollView()
    private lazy var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private lazy var ingredientCollectionView: UICollectionView = factory.makeIngredientCollectionView()
    private lazy var ingredientSuggestionsStack: UIStackView = factory.makeIngredientSuggestionStackView()
    private lazy var ingredientSuggestionTitle: UILabel = factory.makeIngredientSuggestionTitle()
    private lazy var suggestionStackView: UIStackView = factory.makeSuggestionStackView()
    private lazy var categoriesScrollView = factory.makeScrollView()
    
    private lazy var storiesScrollView = factory.makeScrollView()
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

            let searchText = self.searchBar.nonOptionalText
            self.filters = newFilters
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
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
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
//        categoriesScrollView.addSubview(storiesScrollView)
        
        suggestionScrollView.addSubview(suggestionStackView)

        suggestionStackView.addArrangedSubview(ingredientSuggestionsStack)
        ingredientSuggestionsStack.addArrangedSubview(ingredientSuggestionTitle)
        ingredientSuggestionsStack.addArrangedSubview(ingredientCollectionView)
        
        
        view.addSubview(storiesScrollView)
        storiesScrollView.addSubview(storiesStackView)
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
        storiesScrollView.translatesAutoresizingMaskIntoConstraints = false
//        let height = 200 + categoryStackView.intrinsicContentSize.height + cusineStackView.intrinsicContentSize.height
        NSLayoutConstraint.activate([
            suggestionScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            suggestionScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            suggestionScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            suggestionScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            storiesScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            storiesScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            storiesScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            storiesScrollView.heightAnchor.constraint(equalToConstant: 200),
            
            categoriesScrollView.topAnchor.constraint(equalTo: storiesScrollView.bottomAnchor, constant: 20),
            categoriesScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            categoriesScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            storiesScrollView.topAnchor.constraint(equalTo: categoriesScrollView.topAnchor),
//            storiesScrollView.leftAnchor.constraint(equalTo: categoriesScrollView.leftAnchor),
//            storiesScrollView.rightAnchor.constraint(equalTo: categoriesScrollView.rightAnchor),
//            storiesScrollView.bottomAnchor.constraint(equalTo: categoriesScrollView.topAnchor, constant: 200),
//            storiesScrollView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        storiesScrollView.backgroundColor = .systemBackground
        categoriesScrollView.backgroundColor = .systemBackground
        
        suggestionScrollView.layer.opacity = 0
        suggestionScrollView.layer.isHidden = true
//        categoriesScrollView.layer.isHidden = true
        
    }
    
    @objc
    func openStories(_ sender: UITapGestureRecognizer) {
        router.routeToStories()
    }
    
    @objc
    func openRecipesByCuisine(_ sender: UITapGestureRecognizer) {
        router.routeToRecipesScreen(data: RequestType.mealByCuisine(cuisine: "French"), titleText: "French")
    }
    
    @objc
    func openRecipesByCategory(_ sender: UITapGestureRecognizer) {
        router.routeToRecipesScreen(data: RequestType.mealByCategory(category: "Dessert"), titleText: "Dessert")
    }
    
    private func configureStackView() {
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        let offset = (UIScreen.main.bounds.width - categoryStackView.intrinsicContentSize.width) / 2
        suggestionStackView.translatesAutoresizingMaskIntoConstraints = false
        storiesStackView.translatesAutoresizingMaskIntoConstraints = false
        cusineStackView.translatesAutoresizingMaskIntoConstraints = false
        
        storiesStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openStories(_:))))
        cusineStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRecipesByCuisine(_:))))
        categoryStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRecipesByCategory(_:))))
        
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
            
            storiesStackView.topAnchor.constraint(equalTo: storiesScrollView.topAnchor),
            storiesStackView.rightAnchor.constraint(equalTo: storiesScrollView.rightAnchor),
            storiesStackView.bottomAnchor.constraint(equalTo: storiesScrollView.bottomAnchor),
            storiesStackView.leftAnchor.constraint(equalTo: storiesScrollView.leftAnchor),
            
            categoryStackView.topAnchor.constraint(equalTo: categoriesScrollView.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: offset),
            categoryStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -offset),
            categoryStackView.heightAnchor.constraint(equalToConstant: categoryStackView.intrinsicContentSize.height),
            
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
    func displayStart(_ viewModel: Model.Start.ViewModel) {

    }

    func displayAction(_ viewModel: Model.Action.ViewModel) {
//        view.backgroundColor = viewModel.color
    }
    
    func displayRecipes(_ viewModel: MainModel.Recipe.Request) {
        router.routeToRecipesScreen(data: RequestType.mealsByName(name: viewModel.searchText), titleText: searchBar.nonOptionalText)
    }
}

// MARK: - UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
//    func searchBar(_: UISearchBar, textDidChange _: String) {
//        NSObject.cancelPreviousPerformRequests(
//            withTarget: self,
//            selector: #selector(reloadSuggestions),
//            object: nil
//        )
//        self.perform(#selector(reloadSuggestions), with: nil, afterDelay: 0.5)
//    }

    func searchBarSearchButtonClicked(_: UISearchBar) {
        displayRecipes(MainModel.Recipe.Request(searchText: searchBar.nonOptionalText, productsFilter: []))
//        interactor.loadRecipies(MainModel.Recipe.Request(searchText: searchBar.nonOptionalText, productsFilter: []))
//        updateSuggestionLayout(isHidden: true)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        updateSuggestionLayout(isHidden: true)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        updateSuggestionLayout(isHidden: false)
    }

//    @objc private func reloadSuggestions() {
////        search(searchText: searchBar.nonOptionalText)
//    }
}

extension UISearchBar {
    var nonOptionalText: String {
        text ?? ""
    }
}

