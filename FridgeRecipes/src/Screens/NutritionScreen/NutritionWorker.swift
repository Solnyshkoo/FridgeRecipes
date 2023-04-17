import Foundation

final class NutritionWorker: NutritionWorkerLogic {
    private lazy var opQueue = FetchingOperations()

    func getNutritionInfo(id: String, completion: @escaping NutritionCompletion) {
        let getMealNutr = FetchingRecipesOperation(
            type: .nutritionInfo(text: id),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealNutr)
    }
}
