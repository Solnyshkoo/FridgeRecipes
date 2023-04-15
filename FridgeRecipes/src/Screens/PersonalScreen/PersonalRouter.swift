import UIKit

final class PersonalRouter: PersonalRoutingLogic {
    weak var view: UIViewController?
    
    func routeToChangePersonalInfpScreen(interactor: PersonalBusinessLogic) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let vc = ChangePersonalInfoViewController(interactor: interactor)
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .none
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = true
            }
            
            self.view?.present(vc, animated: true, completion: nil)
        }
    }
}

