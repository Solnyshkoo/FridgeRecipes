import Foundation
final class FetchingOperations {
    lazy var fetchingTasks: [IndexPath: Operation] = [:]
    lazy var fetchingQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "FetchingDataQueue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
}
