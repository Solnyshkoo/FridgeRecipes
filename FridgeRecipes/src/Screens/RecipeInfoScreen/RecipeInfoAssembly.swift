import UIKit

enum RecipeInfoAssembly {
    static func build(data: String) -> UIViewController {
        let router = RecipeInfoRouter()
        let presenter = RecipeInfoPresenter()
        let worker = RecipeInfoWorker()
        let interactor = RecipeInfoInteractor(presenter: presenter, worker: worker)
        let viewController = RecipeInfoViewController(
            router: router,
            interactor: interactor,
            data: data
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
