import UIKit

enum RegistrationAssembly {
    static func build() -> UIViewController {
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter()
        let worker = RegistrationWorker()
        let interactor = RegistrationInteractor(presenter: presenter, worker: worker)
        let viewController = RegistrationViewController(
            router: router,
            interactor: interactor
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
