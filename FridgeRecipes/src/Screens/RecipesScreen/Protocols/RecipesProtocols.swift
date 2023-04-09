protocol RecipesBusinessLogic {
    typealias Model = MainModel
//    func loadStart(_ request: Model.Start.Request)
//    func loadAction(_ request: Model.Action.Request)
}

protocol RecipesPresentationLogic {
    typealias Model = MainModel
//    func presentStart(_ response: Model.Start.Response)
//    func presentAction(_ response: Model.Action.Response)
}

protocol RecipesDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayRecipes(_ viewModel: [MainModel.Recipe.ViewModel])
}

protocol RecipesRoutingLogic {
    func routeTo()
}

protocol RecipesWorkerLogic {
    typealias Model = MainModel
    func doSomething()
    
}

