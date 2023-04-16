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
    
    func loadRecipesByIngredient(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealsByIngredient(ingredient: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
    
    func loadRecipesByCusine(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealByCuisine(cuisine: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
    
    func loadRecipesByCategory(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealByCategory(category: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
}
