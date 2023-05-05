import Foundation

final class RecipesWorker: RecipesWorkerLogic {
    // MARK: - Fields

    private lazy var opQueue = FetchingOperations()

    // MARK: - Load recipes by name

    func loadRecipesByName(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealsByName(name: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }

    // MARK: - Load recipes by ingredient

    func loadRecipesByIngredient(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealsByIngredient(ingredient: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }

    // MARK: - Load recipes by cusine

    func loadRecipesByCusine(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealByCuisine(cuisine: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }

    // MARK: - Load recipes by category

    func loadRecipesByCategory(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingRecipesOperation(
            type: .mealByCategory(category: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
}
