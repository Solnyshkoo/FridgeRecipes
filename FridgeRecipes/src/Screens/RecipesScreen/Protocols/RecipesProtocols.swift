protocol RecipesBusinessLogic {
    typealias Model = RecipesModel
    func loadStart(_ request: Model.Start.Request)
    func loadAction(_ request: Model.Action.Request)
}

protocol RecipesPresentationLogic {
    typealias Model = RecipesModel
    func presentStart(_ response: Model.Start.Response)
    func presentAction(_ response: Model.Action.Response)
}

protocol RecipesDisplayLogic: AnyObject {
    typealias Model = RecipesModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayAction(_ viewModel: Model.Action.ViewModel)
}

protocol RecipesRoutingLogic {
    func routeTo()
}

protocol RecipesWorkerLogic {
    func doSomething()
}

protocol NetworkRecipesServiceProtocol {
    
}
