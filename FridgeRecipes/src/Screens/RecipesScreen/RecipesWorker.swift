import Foundation

final class RecipesWorker: RecipesWorkerLogic {
    private lazy var opQueue = FetchingOperations()
    
    func loadRecipesByName(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealsByName(name: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
    
}
