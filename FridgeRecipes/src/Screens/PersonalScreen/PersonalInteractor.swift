import CoreGraphics

final class PersonalInteractor: PersonalBusinessLogic {
    
    // MARK: - Fields
    private let presenter: PersonalPresentationLogic
    private let worker: PersonalWorkerLogic
    
    // MARK: - Lifecycle
    init(presenter: PersonalPresentationLogic, worker: PersonalWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func loadUserInfo() {
        worker.getUserInfo()
    }
    
    func changeValue() {
        worker.saveUserInfo()
        presenter.updatePersonalView()
    }
    
}
