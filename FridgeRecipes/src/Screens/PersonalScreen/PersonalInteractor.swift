import CoreGraphics

final class PersonalInteractor: PersonalBusinessLogic {
    // MARK: - Fields

    private let presenter: PersonalPresentationLogic
    private let worker: PersonalWorkerLogic
    
    // MARK: - Init

    init(presenter: PersonalPresentationLogic, worker: PersonalWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Get user info

    func loadUserInfo() {
        worker.getUserInfo()
    }
    
    // MARK: - Change user info

    func changeValue() {
        worker.saveUserInfo()
        presenter.updatePersonalView()
    }
}
