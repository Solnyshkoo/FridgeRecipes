import CoreGraphics

final class MainInteractor: MainBusinessLogic {
    // MARK: - Fields

    private let presenter: MainPresentationLogic
    private let worker: MainWorkerLogic

    // MARK: - Lifecycle

    init(presenter: MainPresentationLogic, worker: MainWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
