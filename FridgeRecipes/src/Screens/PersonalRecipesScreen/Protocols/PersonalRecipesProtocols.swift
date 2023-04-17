protocol PersonalRecipesBusinessLogic {
    typealias Model = MainModel
    func loadRecipies(_ request: Model.Recipe.Request)
}

protocol PersonalRecipesPresentationLogic {
    typealias Model = MainModel
    func presentRecipes(_ response: Model.Recipe.Response)
}

protocol PersonalRecipesDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayRecipes(_ viewModel: [MainModel.Recipe.ViewModel])
}

protocol PersonalRecipesRoutingLogic {
    func routeToRecipeInfoScreen(data: String)
}

protocol PersonalRecipesWorkerLogic {
    typealias Model = MainModel
    typealias MealsCompletion = (Result<Model.Recipe.Response, NetworkError>) -> Void
    func loadRecipesByName(name: String, completion: @escaping MealsCompletion)
}
