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
        for i in 0 ..< request.text.count {
            worker.getNutritionInfo(id: request.text[i]) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case let .success(items):
                    
                    if i == request.text.count - 1 {
                        self.presenter.presentNutritionInfo(items, show: true)
                    } else {
                        self.presenter.presentNutritionInfo(items, show: false)
                    }

                case .failure:
                    break
                }
            }
        }
    }
}
