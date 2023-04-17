import UIKit

final class RegistrationPresenter: RegistrationPresentationLogic {
    weak var view: RegistrationDisplayLogic?

    func presentError(_ response: Model.Response) {
        let nameError = response.nameError == nil ? "" : response.nameError
        let ageError = response.ageError == nil ? "" : response.ageError
        view?.displayError(RegistrationInfo.Response(nameError: nameError, ageError: ageError))
    }

    func presentScreen(_ viewModel: Model.ViewModel) {
        view?.displayMainScreen(viewModel)
    }
}
