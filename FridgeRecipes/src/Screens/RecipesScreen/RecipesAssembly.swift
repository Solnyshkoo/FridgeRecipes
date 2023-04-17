import UIKit

enum RecipesAssembly {
    static func build(data: RequestType, titleText: String) -> UIViewController {
        let router = RecipesRouter()
        let presenter = RecipesPresenter()
        let worker = RecipesWorker()
        let interactor = RecipesInteractor(presenter: presenter, worker: worker)
        let viewController = RecipesViewController(
            router: router,
            interactor: interactor,
            data: data,
            titleText: titleText
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
