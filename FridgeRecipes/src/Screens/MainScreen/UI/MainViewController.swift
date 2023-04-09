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
    private lazy var suggestionScrollView = factory.makeSuggestionsScrollView()
    private lazy var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private lazy var ingredientCollectionView: UICollectionView = factory.makeIngredientCollectionView()
    private lazy var ingredientSuggestionsStack: UIStackView = factory.makeIngredientSuggestionStackView()
    private lazy var ingredientSuggestionTitle: UILabel = factory.makeIngredientSuggestionTitle()
    private lazy var suggestionStackView: UIStackView = factory.makeSuggestionStackView()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addSubviews()
        configureSearchBar()
        configureResultCollectionView()
        configureScrollView()
        configureStackView()
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
        NSLayoutConstraint.activate([
            suggestionScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            suggestionScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            suggestionScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            suggestionScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        suggestionScrollView.layer.opacity = 0
        suggestionScrollView.layer.isHidden = true
    }
    
    private func configureStackView() {
        suggestionStackView.translatesAutoresizingMaskIntoConstraints = false
        suggestionStackView.axis = .vertical
        suggestionStackView.distribution = .fill
        suggestionStackView.alignment = .fill

        NSLayoutConstraint.activate([
            suggestionStackView.topAnchor.constraint(equalTo: suggestionScrollView.topAnchor),
            suggestionStackView.leftAnchor.constraint(equalTo: suggestionScrollView.leftAnchor),
            suggestionStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            suggestionStackView.bottomAnchor.constraint(equalTo: suggestionScrollView.bottomAnchor),
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
    
    func displayRecipes(_ viewModel: [Model.Recipe.ViewModel]) {
        router.routeToRecipesScreen(data: viewModel)
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else {
//                return
//            }
////            self.present(RecipesAssembly.build(data: viewModel), animated: true)
//            self.navigationController?.pushViewController(RecipesAssembly.build(data: viewModel), animated: true)
//        }
//
////        self.view.navigationController?.pushViewController(RecipesAssembly.build(data: viewModel), animated: true)
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
        interactor.loadRecipies(MainModel.Recipe.Request(searchText: searchBar.nonOptionalText, productsFilter: []))
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

