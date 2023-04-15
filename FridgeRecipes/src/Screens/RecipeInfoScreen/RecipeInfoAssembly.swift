import UIKit

enum RecipeInfoAssembly {
    static func build(data: String) -> UIViewController {
        let router: RecipeInfoRouter = RecipeInfoRouter()
        let presenter: RecipeInfoPresenter = RecipeInfoPresenter()
        let worker:RecipeInfoWorker = RecipeInfoWorker()
        let interactor: RecipeInfoInteractor = RecipeInfoInteractor(presenter: presenter, worker: worker)
        let viewController: RecipeInfoViewController = RecipeInfoViewController(
            router: router,
            interactor: interactor,
            data: data
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
