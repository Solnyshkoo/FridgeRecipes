import UIKit

enum NutritionAssembly {
    static func build(data: String) -> UIViewController {
        let presenter: NutritionPresenter = NutritionPresenter()
        let worker: NutritionWorker = NutritionWorker()
        let interactor: NutritionInteractor = NutritionInteractor(presenter: presenter, worker: worker)
        let viewController: NutritionViewController = NutritionViewController(
            interactor: interactor,
            data: data
        )

        presenter.view = viewController

        return viewController
    }
}
