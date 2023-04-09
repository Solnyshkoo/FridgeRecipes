import UIKit

enum RecipesAssembly {
    // FIXME: - надо передавать через протокол [MainModel.Recipe.Response]
    static func build(data: [MainModel.Recipe.ViewModel]) -> UIViewController {
        let router: RecipesRouter = RecipesRouter()
        let presenter: RecipesPresenter = RecipesPresenter(data: data)
        let worker: RecipesWorker = RecipesWorker()
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
