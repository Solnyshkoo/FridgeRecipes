protocol MainBusinessLogic {
}

protocol MainPresentationLogic {
    typealias Model = MainModel
}

protocol MainDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayRecipes(_ viewModel: MainModel.Recipe.Request)
}

protocol MainRoutingLogic {
    func routeToRecipesScreen(data: RequestType, titleText: String)
    func routeToStories()
}

protocol MainWorkerLogic {
}

protocol NetworkRecipesServiceProtocol {}
