import Foundation
protocol RecipesBusinessLogic {
    typealias Model = MainModel
    func loadRecipiesByName(_ request: Model.Recipe.Request)
    func loadRecipiesByIngredient(_ request: Model.Recipe.Request, showNew: Bool)
    func loadRecipiesByCategory(_ request: Model.Recipe.Request)
    func loadRecipiesByCusine(_ request: Model.Recipe.Request)
}

protocol RecipesPresentationLogic {
    typealias Model = MainModel
    func presentRecipes(_ response: Model.Recipe.Response, showNew: Bool)
    func addRecipes(_ response: Model.Recipe.Response)
    func presentNothing()
}

protocol RecipesDisplayLogic: AnyObject {
    typealias Model = MainModel
    func displayRecipes(_ viewModel: [MainModel.Recipe.ViewModel], showNew: Bool)
    func displayAdditionalRecipes(_ viewModel: [MainModel.Recipe.ViewModel])
    func displayNothingFound()
}

protocol RecipesRoutingLogic {
    func routeToRecipeInfoScreen(data: String)
}

protocol RecipesWorkerLogic {
    typealias Model = MainModel
    typealias MealsCompletion = (Result<Model.Recipe.Response, NetworkError>) -> Void
    func loadRecipesByName(name: String, completion: @escaping MealsCompletion)
    func loadRecipesByIngredient(name: String, completion: @escaping MealsCompletion)
    func loadRecipesByCategory(name: String, completion: @escaping MealsCompletion)
    func loadRecipesByCusine(name: String, completion: @escaping MealsCompletion)
}
