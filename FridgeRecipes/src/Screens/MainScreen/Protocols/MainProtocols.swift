protocol MainBusinessLogic {
    typealias Model = MainModel
    func loadStart(_ request: Model.Start.Request)
    func loadAction(_ request: Model.Action.Request)
    func loadRecipies(_ request: Model.Recipe.Request)
}

protocol MainPresentationLogic {
    typealias Model = MainModel
    func presentStart(_ response: Model.Start.Response)
    func presentAction(_ response: Model.Action.Response)
    func presentRecipes(_ response: Model.Recipe.Response)
}

protocol MainDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayAction(_ viewModel: Model.Action.ViewModel)
    func displayRecipes(_ viewModel: [Model.Recipe.ViewModel]) 
}

protocol MainRoutingLogic {
    func routeToRecipesScreen(data: [MainModel.Recipe.ViewModel])
}

protocol MainWorkerLogic {
    typealias Model = MainModel
    typealias MealsCompletion = (Result<Model.Recipe.Response, NetworkError>) -> Void
    
    func loadRecipesByName(name: String, completion: @escaping MealsCompletion)
    func doSomething()
    
}

protocol NetworkRecipesServiceProtocol {
    
}
