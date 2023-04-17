import Foundation

final class PersonalRecipesInteractor: PersonalRecipesBusinessLogic {
    // MARK: - Fields

    private let presenter: PersonalRecipesPresentationLogic
    private let worker: PersonalRecipesWorkerLogic
    
    // MARK: - Lifecycle

    init(presenter: PersonalRecipesPresentationLogic, worker: PersonalRecipesWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func loadRecipies(_ request: Model.Recipe.Request) {
        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
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
                    break
                }
                DispatchQueue.main.async {}
            }
        }
    }
}
