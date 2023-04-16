import UIKit
import CloudKit
import CoreData

final class RecipesViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let recipesCellType = RecipesCell.self
        static let recipesCellID = RecipesCell.cellID
    }
    
    // MARK: - Fields
    private let router: RecipesRoutingLogic
    private let interactor: RecipesBusinessLogic
    private let tableView: UITableView = UITableView()
    private let nothingFound = NothingFoundStack()
    
    private var recipes: [MainModel.Recipe.ViewModel] = []
    
    // MARK: - LifeCycle
    init(
        router: RecipesRoutingLogic,
        interactor: RecipesBusinessLogic,
        data: RequestType,
        titleText: String
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        getData(data: data)
        title = titleText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        configureUI()
        super.viewWillAppear(animated)
    }
    
    private func configureUI() {
        setupTableView()
    }

    
    func getData(data: RequestType) {
        switch data {
        case .mealsByIngredient(let ingredient):
            interactor.loadRecipiesByIngredient(MainModel.Recipe.Request(searchText: ingredient, productsFilter: []), showNew: true)
        case .mealsByName(let name):
            interactor.loadRecipiesByName(MainModel.Recipe.Request(searchText: name, productsFilter: []))
        case .mealByCuisine(let cuisine):
            interactor.loadRecipiesByCusine(MainModel.Recipe.Request(searchText: cuisine, productsFilter: []))
        case .mealByCategory(let category):
            interactor.loadRecipiesByCategory(MainModel.Recipe.Request(searchText: category, productsFilter: []))
        default:
            displayNothingFound()
        }
    
    }
    
    // MARK: - setup TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(Constants.recipesCellType, forCellReuseIdentifier: Constants.recipesCellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        
        
        view.addSubview(nothingFound)
        nothingFound.isHidden = true
        nothingFound.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nothingFound.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            nothingFound.centerYAnchor
                .constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Protocol DisplayLogic
extension RecipesViewController: RecipesDisplayLogic {

    
    func displayStart(_ viewModel: Model.Start.ViewModel) {

    }

    func displayAction(_ viewModel: Model.Action.ViewModel) {
    }
    
    func displayRecipes(_ viewModel: [MainModel.Recipe.ViewModel], showNew: Bool) {

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            self.recipes = viewModel
            if showNew {
                self.tableView.reloadData()
            }
            self.nothingFound.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func displayAdditionalRecipes(_ viewModel: [MainModel.Recipe.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            viewModel.forEach { item in
                self.recipes.append(item)
            }
            self.tableView.reloadData()
            self.nothingFound.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func displayNothingFound() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            
            self.nothingFound.isHidden = false
            self.tableView.isHidden = true
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: create cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = recipes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.recipesCellID,
            for: indexPath
        ) as? RecipesCell
        
        cell?.configure(data: item)
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        interactor.loadRecipeInfo(recipes[indexPath.row])
        router.routeToRecipeInfoScreen(data: recipes[indexPath.row].id)
    }
    
    
//    // FIXME: - setup swipe share
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let article = self.data[(indexPath as NSIndexPath).row] as ArticleModel.Fetch.ArticleView
//        let shareAction = UIContextualAction(style: .normal, title: "Share") {
//            (action, sourceView, completionHandler) in
//            self.swipeShareAction(article, indexPath: indexPath)
//            completionHandler(true)
//        }
//        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction])
//        return swipeConfiguration
//    }
    
//    fileprivate func swipeShareAction(_ article: ArticleModel.Fetch.ArticleView, indexPath: IndexPath) {
//
//        let uploadItems = [article.articleUrl as AnyObject]
//        let activityController = UIActivityViewController(activityItems: uploadItems, applicationActivities: nil)
//        if let popoverController = activityController.popoverPresentationController {
//            if let cell = tableView.cellForRow(at: indexPath) {
//                popoverController.sourceView = cell
//                popoverController.sourceRect = cell.bounds
//            }
//        }
//        self.present(activityController, animated: true, completion: nil)
//    }
}
