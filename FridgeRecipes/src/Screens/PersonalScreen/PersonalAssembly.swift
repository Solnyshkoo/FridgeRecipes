import UIKit

enum PersonalAssembly {
    static func build(data: RegistrationInfo.ViewModel) -> UIViewController {
        let router: PersonalRouter = PersonalRouter()
        let presenter: PersonalPresenter = PersonalPresenter()
        let worker: PersonalWorker = PersonalWorker()
        let interactor: PersonalInteractor = PersonalInteractor(presenter: presenter, worker: worker)
        let viewController: PersonalViewController = PersonalViewController(
            router: router,
            interactor: interactor,
            data: data
        )

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
