import UIKit

enum MainAssembly {
    static func build() -> UIViewController {
        let router: MainRouter = MainRouter()
        let presenter: MainPresenter = MainPresenter()
        let worker: MainWorker = MainWorker()
        let interactor: MainInteractor = MainInteractor(presenter: presenter, worker: worker)
        let viewController: MainViewController = MainViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
