import UIKit

enum MainAssembly {
    static func build() -> UIViewController {
        let router = MainRouter()
        let presenter = MainPresenter()
        let worker = MainWorker()
        let interactor = MainInteractor(presenter: presenter, worker: worker)
        let viewController = MainViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
