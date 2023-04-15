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
    
    func loadRecipies(_ request: Model.Recipe.Request) {
        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
           // FIXME: - сделать что-то
            return
        }
        
        if !request.searchText.isEmpty {
            worker.loadRecipesByName(name: request.searchText) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case let .success(items):
                    self.presenter.presentRecipes(items)
                case .failure:
                    print("EROR")
                }
                DispatchQueue.main.async {
                }
            }
        }
        
    }
}
