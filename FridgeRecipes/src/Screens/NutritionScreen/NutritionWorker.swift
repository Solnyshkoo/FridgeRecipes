import Foundation

final class NutritionWorker: NutritionWorkerLogic {
    // MARK: - Fields

    private lazy var opQueue = FetchingOperations()

    // MARK: - Load nutrition info from API

    func getNutritionInfo(id: String, completion: @escaping NutritionCompletion) {
        let getMealNutr = FetchingRecipesOperation(
            type: .nutritionInfo(text: id),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealNutr)
    }
}
