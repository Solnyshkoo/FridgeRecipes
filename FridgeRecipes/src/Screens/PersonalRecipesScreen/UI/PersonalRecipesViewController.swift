import UIKit
import CloudKit
import CoreData

final class PersonalRecipesViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let recipesCellType = RecipesCell.self
        static let recipesCellID = RecipesCell.cellID
    }
    
    // MARK: - Fields
    private let router: PersonalRecipesRoutingLogic
    private let interactor: PersonalRecipesBusinessLogic
    private let tableView: UITableView = UITableView()
    
    private var recipes: [MainModel.Recipe.ViewModel] = []
    
    // MARK: - LifeCycle
    init(
        router: PersonalRecipesRoutingLogic,
        interactor: PersonalRecipesBusinessLogic,
        data: [MainModel.Recipe.ViewModel],
        title: String
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        recipes = data
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        configureUI()
        self.title = title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        configureUI()
        super.viewWillAppear(animated)
    }
//
    private func configureUI() {
        setupTableView()
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
    }
}

// MARK: - Protocol DisplayLogic
extension PersonalRecipesViewController: PersonalRecipesDisplayLogic {
    func displayStart(_ viewModel: Model.Start.ViewModel) {

    }

    func displayAction(_ viewModel: Model.Action.ViewModel) {
    }
    
    func displayRecipes(_ viewModel: [MainModel.Recipe.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            self.recipes = viewModel
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PersonalRecipesViewController: UITableViewDelegate, UITableViewDataSource {
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
