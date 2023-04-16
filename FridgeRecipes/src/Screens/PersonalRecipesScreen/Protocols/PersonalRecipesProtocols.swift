protocol PersonalRecipesBusinessLogic {
    typealias Model = MainModel
    func loadRecipies(_ request: Model.Recipe.Request)
//    func loadStart(_ request: Model.Start.Request)
//    func loadAction(_ request: Model.Action.Request)
    
//    func loadRecipeInfo(_ request: MainModel.Recipe.ViewModel)
}

protocol PersonalRecipesPresentationLogic {
    typealias Model = MainModel
    func presentRecipes(_ response: Model.Recipe.Response)
//    func presentStart(_ response: Model.Start.Response)
//    func presentAction(_ response: Model.Action.Response)
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

