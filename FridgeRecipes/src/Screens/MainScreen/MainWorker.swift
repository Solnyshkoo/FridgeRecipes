import Foundation

final class MainWorker: MainWorkerLogic {
    private lazy var opQueue = FetchingOperations()

    func doSomething() {}

    func loadRecipesByIngredient() {}
}

final class FetchingOperations {
    lazy var fetchingTasks: [IndexPath: Operation] = [:]
    lazy var fetchingQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "FetchingDataQueue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
}
