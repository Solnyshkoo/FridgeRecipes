import UIKit

final class RecipesViewController: UIViewController, RecipesDisplayLogic {
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }

    // MARK: - Fields
    private let router: RecipesRoutingLogic
    private let interactor: RecipesBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: RecipesRoutingLogic,
        interactor: RecipesBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        configureUI()
//        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {

    }

    func displayAction(_ viewModel: Model.Action.ViewModel) {
//        view.backgroundColor = viewModel.color
    }

}
