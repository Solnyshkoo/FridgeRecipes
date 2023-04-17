import CoreGraphics

final class RegistrationInteractor: RegistrationBusinessLogic {
    // MARK: - Fields

    private let presenter: RegistrationPresentationLogic
    private let worker: RegistrationWorkerLogic

    // MARK: - Lifecycle

    init(presenter: RegistrationPresentationLogic, worker: RegistrationWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    func buttonTapped(_ request: Model.Request) {
        let name = nameError(text: request.name)
        let age = ageError(text: request.age)
        if name != nil || age != nil {
            presenter.presentError(RegistrationInfo.Response(
                nameError: name,
                ageError: age
            ))
        } else {
            let model = RegistrationInfo.ViewModel(
                name: request.name,
                age: request.age,
                sex: request.sex
            )

            presenter.presentScreen(model)
            worker.saveData(model)
        }
    }

    private func nameError(text: String) -> String? {
        if text.isEmpty {
            return "Empty"
        } else {
            return nil
        }
    }

    private func ageError(text: String) -> String? {
        if text.isEmpty {
            return "Empty"
        } else if !text.isInt() {
            return "Wrong age"
        } else {
            return nil
        }
    }
}

extension String {
    func isInt() -> Bool {
        guard let _ = Int(self) else {
            return false
        }
        return true
    }
}
