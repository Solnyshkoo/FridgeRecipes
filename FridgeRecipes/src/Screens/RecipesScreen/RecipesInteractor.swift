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
    
    func loadRecipiesByName(_ request: Model.Recipe.Request) {
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
                    self.presenter.presentRecipes(items, showNew: false)
                    self.loadRecipiesByIngredient(request, showNew: false)
                case .failure:
                    self.loadRecipiesByIngredient(request, showNew: true)
                }
            }
        }
    }
    
    func loadRecipiesByIngredient(_ request: Model.Recipe.Request, showNew: Bool) {
        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
            return
        }
        
        if !request.searchText.isEmpty {
            worker.loadRecipesByIngredient(name: request.searchText) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case let .success(items):
                    if showNew {
                        self.presenter.presentRecipes(items, showNew: true)
                    } else {
                        self.presenter.addRecipes(items)
                    }
                case .failure:
                    if showNew {
                        self.presenter.presentNothing()
                    } else {
                        self.presenter.addRecipes(MainModel.Recipe.Response(meals: []))
                    }
                }
            }
        }
    }
    
    func loadRecipiesByCategory(_ request: Model.Recipe.Request) {
        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
            return
        }
        
        if !request.searchText.isEmpty {
            worker.loadRecipesByCategory(name: request.searchText) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case let .success(items):
                    self.presenter.presentRecipes(items, showNew: true)

                case .failure:
                    self.presenter.presentNothing()
                }
            }
        }
    }
    
    func loadRecipiesByCusine(_ request: Model.Recipe.Request) {
        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
            return
        }
        
        if !request.searchText.isEmpty {
            worker.loadRecipesByCusine(name: request.searchText) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case let .success(items):
                    self.presenter.presentRecipes(items, showNew: true)

                case .failure:
                    self.presenter.presentNothing()
                }
            }
        }
    }
}
