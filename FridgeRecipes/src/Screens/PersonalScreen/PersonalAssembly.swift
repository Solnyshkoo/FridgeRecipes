import UIKit

enum PersonalAssembly {
    static func build(data: RegistrationInfo.ViewModel) -> UIViewController {
        let router = PersonalRouter()
        let presenter = PersonalPresenter()
        let worker = PersonalWorker()
        let interactor = PersonalInteractor(presenter: presenter, worker: worker)
        let viewController = PersonalViewController(
            router: router,
            interactor: interactor,
            data: data
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
