import Foundation
final class RecipeInfoWorker: RecipeInfoWorkerLogic {

    private lazy var opQueue = FetchingOperations()
    
    func getRecipeInfo(id: String, completion: @escaping MealsCompletion) {
        let getMealById = FetchingRecipesOperation(
            type: .detailsById(id: id),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealById)
    }
}
