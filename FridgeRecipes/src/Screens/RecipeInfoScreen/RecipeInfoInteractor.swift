import CoreGraphics
import Foundation
final class RecipeInfoInteractor: RecipeInfoBusinessLogic {
    // MARK: - Fields

    private let presenter: RecipeInfoPresentationLogic
    private let worker: RecipeInfoWorkerLogic
    
    // MARK: - Lifecycle

    init(presenter: RecipeInfoPresentationLogic, worker: RecipeInfoWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Load recipes

    func loadRecipe(_ request: Model.Start.Request) {
        worker.getRecipeInfo(id: request.id) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .success(items):
                self.presenter.presentRecipes(items, nil)
                
                
            case .failure:
                break
            }
        }
    }
    
    func getImage(url: URL) {
        worker.downloadImage(from: url) { data, _ , _ in
            self.presenter.presentImage(data: data)
        }
    }
    
    // MARK: - Load Nutrition Info

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
    
    
    // MARK: - Save favorite recipe

    func saveFav(data: MainModel.Recipe.ViewModel) {
        worker.saveFav(data: data)
    }
    
    // MARK: - Save reward

    func saveReward(data: RewardInfo.ViewModel) {
        worker.saveReward(data: data)
    }
    
    // MARK: - Save cooked recipe

    func saveCooked(data: MainModel.Recipe.ViewModel) {
        worker.saveCooked(data: data)
    }
    
    // MARK: - Delete favorite recipe

    func deleteFav(id: String) {
        worker.deleteFav(id: id)
    }
   
    // MARK: - Delete cooked recipe

    func deleteCooked(id: String) {
        worker.deleteCooked(id: id)
    }
}
