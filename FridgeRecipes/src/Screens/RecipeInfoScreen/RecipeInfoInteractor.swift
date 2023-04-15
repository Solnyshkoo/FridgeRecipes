import CoreGraphics
//protocol CleanSceneDataStore {       // To store or pass data
//    var someStringToStoreOrPass: String { get set }
//}

final class RecipeInfoInteractor: RecipeInfoBusinessLogic {
    // MARK: - Fields
    private let presenter: RecipeInfoPresentationLogic
    private let worker: RecipeInfoWorkerLogic
    
    // MARK: - Lifecycle
    init(presenter: RecipeInfoPresentationLogic, worker: RecipeInfoWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    func loadRecipe(_ request: Model.Start.Request) {
        worker.getRecipeInfo(id: request.id) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .success(items):
                print(items)
                self.presenter.presentRecipes(items)
            case .failure:
                print("EROR")
            }
        }
    }
    
}
