protocol MainBusinessLogic {
    typealias Model = MainModel
    func loadStart(_ request: Model.Start.Request)
    func loadAction(_ request: Model.Action.Request)
}

protocol MainPresentationLogic {
    typealias Model = MainModel
    func presentStart(_ response: Model.Start.Response)
    func presentAction(_ response: Model.Action.Response)
}

protocol MainDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayAction(_ viewModel: Model.Action.ViewModel)
    func displayRecipes(_ viewModel: MainModel.Recipe.Request)
}

protocol MainRoutingLogic {
    func routeToRecipesScreen(data: RequestType, titleText: String)
    func routeToStories()
}

protocol MainWorkerLogic {
    typealias Model = MainModel
    func doSomething()
}

protocol NetworkRecipesServiceProtocol {}
