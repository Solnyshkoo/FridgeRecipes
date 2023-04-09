import CoreGraphics


final class RecipesInteractor: RecipesBusinessLogic {
    // MARK: - Fields
    private let presenter: RecipesPresentationLogic
    private let worker: RecipesWorkerLogic
    
    
    // MARK: - Lifecycle
    init(presenter: RecipesPresentationLogic, worker: RecipesWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
