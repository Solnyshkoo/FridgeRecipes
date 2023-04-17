import UIKit

enum NutritionAssembly {
    static func build(data: [String]) -> UIViewController {
        let presenter = NutritionPresenter()
        let worker = NutritionWorker()
        let interactor = NutritionInteractor(presenter: presenter, worker: worker)
        let viewController = NutritionViewController(
            interactor: interactor,
            data: data
        )

        presenter.view = viewController

        return viewController
    }
}
