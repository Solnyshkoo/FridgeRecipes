import Foundation

final class MainWorker: MainWorkerLogic {
    private lazy var opQueue = FetchingOperations()
    func doSomething() {
    }
    
    // FIXME: добавить протокол к серверу или удалить
//     let service: NetworkRecipesServiceProtocol
//    
//     init(service: NetworkRecipesServiceProtocol) {
//         self.service = service
//     }
    
    func loadRecipesByName(name: String, completion: @escaping MealsCompletion) {
        let getMealByName = FetchingDataOperation(
            type: .mealsByName(name: name),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealByName)
    }
    
    func loadRecipesByIngredient() {
        
    }
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
