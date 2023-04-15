import Foundation
protocol RecipeInfoBusinessLogic {
    typealias Model = RecipeInfoModel
    func loadRecipe(_ request: Model.Start.Request)
//    func loadStart(_ request: Model.Start.Request)
//    func loadAction(_ request: Model.Action.Request)
}

protocol RecipeInfoPresentationLogic {
    typealias Model = RecipeInfoModel
    func showRecipe(_ response: RecipeInfo)
    func presentRecipes(_ response: Model.Start.Response)
//    func presentStart(_ response: Model.Start.Response)
//    func presentAction(_ response: Model.Action.Response)
}

protocol RecipeInfoDisplayLogic: AnyObject {
    typealias Model = RecipeInfoModel
    func displayRecipe(_ viewModel: RecipeInfo)
}

protocol RecipeInfoRoutingLogic {
    func routeToNutritionScreen(data: String)
}

protocol RecipeInfoWorkerLogic {
    typealias Model = RecipeInfoModel
    typealias MealsCompletion = (Result< Model.Start.Response, NetworkError>) -> Void
    func getRecipeInfo(id: String, completion: @escaping MealsCompletion)
//    func doSomething()
    
}
