import UIKit

enum RegistrationAssembly {
    static func build() -> UIViewController {
        let router: RegistrationRouter = RegistrationRouter()
        let presenter: RegistrationPresenter = RegistrationPresenter()
        let worker: RegistrationWorker = RegistrationWorker()
        let interactor: RegistrationInteractor = RegistrationInteractor(presenter: presenter, worker: worker)
        let viewController: RegistrationViewController = RegistrationViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
