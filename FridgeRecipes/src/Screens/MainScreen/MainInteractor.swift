import CoreGraphics
//protocol CleanSceneDataStore {       // To store or pass data
//    var someStringToStoreOrPass: String { get set }
//}

final class MainInteractor: MainBusinessLogic {
    // MARK: - Fields
    private let presenter: MainPresentationLogic
    private let worker: MainWorkerLogic
    
    // MARK: - Lifecycle
    init(presenter: MainPresentationLogic, worker: MainWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }

    func loadAction(_ request: Model.Action.Request) {
    }
    
//    func loadRecipies(_ request: Model.Recipe.Request) {
//        guard !(request.searchText.isEmpty && request.productsFilter.isEmpty) else {
//           // FIXME: - сделать что-то
//            return
//        }
//        
//        if !request.searchText.isEmpty {
//            worker.loadRecipesByName(name: request.searchText) { [weak self] result in
//                guard let self = self else {
//                    return
//                }
//                
//                switch result {
//                case let .success(items):
//                    self.presenter.presentRecipes(items)
//                case .failure:
//                    print("EROR")
//                }
//                DispatchQueue.main.async {
//                }
//            }
//        }
//        
//    }
}
