import Foundation
protocol RegistrationBusinessLogic {
    typealias Model = RegistrationInfo
    func buttonTapped(_ request: Model.Request)
}

protocol RegistrationPresentationLogic {
    typealias Model = RegistrationInfo
    func presentError(_ response: Model.Response)
    func presentScreen(_ viewModel: Model.ViewModel)
}

protocol RegistrationDisplayLogic: AnyObject {
    typealias Model = RegistrationInfo
    func displayError(_ response: Model.Response)
    func displayMainScreen(_ viewModel: Model.ViewModel)
}

protocol RegistrationRoutingLogic {
    typealias Model = RegistrationInfo
    func openMainScreen(_ data: Model.ViewModel)
}

protocol RegistrationWorkerLogic {
    typealias Model = RegistrationInfo
    func saveData(_ viewModel: Model.ViewModel)
}
