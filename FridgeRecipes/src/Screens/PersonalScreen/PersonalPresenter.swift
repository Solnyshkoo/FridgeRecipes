import UIKit

final class PersonalPresenter: PersonalPresentationLogic {
    weak var view: PersonalDisplayLogic?

    func updatePersonalView() {
        view?.updatePersonalData()
    }
    
}
