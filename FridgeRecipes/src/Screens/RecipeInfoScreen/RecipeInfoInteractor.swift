import CoreGraphics

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
                break
            }
        }
    }
    
    func loadNutrition(_ request: [Ingredient]?) {
        guard let request = request else {
            return
        }
        presenter.presentNutr(parseIngredient(data: request))
    }
    
    private func parseIngredient(data: [Ingredient]) -> [String] {
        var parseData: [String] = []
        
        data.forEach { item in
            let g = ((item.measure ?? "") + " " + item.name)
            parseData.append(g)
        }
        
        return parseData
    }
    
    func saveFav(data: MainModel.Recipe.ViewModel) {
        worker.saveFav(data: data)
    }
    
    func saveReward(data: RewardInfo.ViewModel) {
        worker.saveReward(data: data)
    }
    
    func save(data: MainModel.Recipe.ViewModel) {
        worker.save(data: data)
    }
    
    func deleteFav(id: String) {
        worker.deleteFav(id: id)
    }
    
    func deleteCooked(id: String) {
        worker.deleteCooked(id: id)
    }
}
