import CoreGraphics
//protocol CleanSceneDataStore {       // To store or pass data
//    var someStringToStoreOrPass: String { get set }
//}
final class RecipesInteractor: RecipesBusinessLogic {
    // MARK: - Fields
    private let presenter: RecipesPresentationLogic
    private let worker: RecipesWorkerLogic
    
    // MARK: - Lifecycle
    init(presenter: RecipesPresentationLogic, worker: RecipesWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }

    func loadAction(_ request: Model.Action.Request) {
    }
}
