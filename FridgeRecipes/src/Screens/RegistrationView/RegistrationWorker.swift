import Foundation
final class RegistrationWorker: RegistrationWorkerLogic {

    func saveData(_ viewModel: Model.ViewModel) {
        let defaults = UserDefaults.standard
        defaults.set(viewModel.name, forKey: "name")
        defaults.set(viewModel.age, forKey: "age")
        defaults.set(viewModel.sex, forKey: "gender")
        defaults.set(viewModel.level, forKey: "level")
    }
}
