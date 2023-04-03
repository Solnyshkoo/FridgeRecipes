import UIKit

enum RecipesAssembly {
    static func build() -> UIViewController {
        let service: RecipesService = RecipesService()
        let router: RecipesRouter = RecipesRouter()
        let presenter: RecipesPresenter = RecipesPresenter()
        let worker: RecipesWorker = RecipesWorker(service: service)
        let interactor: RecipesInteractor = RecipesInteractor(presenter: presenter, worker: worker)
        let viewController: RecipesViewController = RecipesViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
