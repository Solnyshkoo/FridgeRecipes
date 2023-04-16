import CoreGraphics

final class NutritionInteractor: NutritionBusinessLogic {
    
    // MARK: - Fields
    private let presenter: NutritionPresentationLogic
    private let worker: NutritionWorkerLogic
    
    // MARK: - Lifecycle
    init(presenter: NutritionPresentationLogic, worker: NutritionWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - BusinessLogic
    func loadNutritionInfo(_ request: Model.Request) {
    }
}
