import UIKit

final class RegistrationRouter: RegistrationRoutingLogic {
    weak var view: UIViewController?

    func openMainScreen(_ data: Model.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(TabBar(userInfo: data), animated: true)
        }
    }
}
