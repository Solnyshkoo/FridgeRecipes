import UIKit

enum PersonalRecipesAssembly {
    static func build(data: [MainModel.Recipe.ViewModel], title: String) -> UIViewController {
        let router: PersonalRecipesRouter = PersonalRecipesRouter()
        let presenter: PersonalRecipesPresenter = PersonalRecipesPresenter()
        let worker: PersonalRecipesWorker = PersonalRecipesWorker()
        let interactor: PersonalRecipesInteractor = PersonalRecipesInteractor(presenter: presenter, worker: worker)
        let viewController: PersonalRecipesViewController = PersonalRecipesViewController(
            router: router,
            interactor: interactor,
            data: data,
            title: title
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
