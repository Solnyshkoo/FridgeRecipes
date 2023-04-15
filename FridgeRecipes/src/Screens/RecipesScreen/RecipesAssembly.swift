import UIKit

enum RecipesAssembly {
    // FIXME: - надо передавать через протокол [MainModel.Recipe.Response]
    static func build(data: MainModel.Recipe.Request) -> UIViewController {
        let router: RecipesRouter = RecipesRouter()
        let presenter: RecipesPresenter = RecipesPresenter()
        let worker: RecipesWorker = RecipesWorker()
        let interactor: RecipesInteractor = RecipesInteractor(presenter: presenter, worker: worker)
        let viewController: RecipesViewController = RecipesViewController(
            router: router,
            interactor: interactor,
            data: data
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
