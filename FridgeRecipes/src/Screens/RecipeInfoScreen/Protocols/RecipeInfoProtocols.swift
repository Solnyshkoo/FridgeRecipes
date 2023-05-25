import Foundation
protocol RecipeInfoBusinessLogic {
    typealias Model = RecipeInfoModel
    func loadRecipe(_ request: Model.Start.Request)
    func loadNutrition(_ request: [Ingredient]?)
    func saveCooked(data: MainModel.Recipe.ViewModel)
    func saveFav(data: MainModel.Recipe.ViewModel)
    func saveReward(data: RewardInfo.ViewModel)
    func deleteFav(id: String)
    func deleteCooked(id: String)
    func getImage(url: URL)
//    func getImage(from url: URL, completion: @escaping (Data?) -> ())
}

protocol RecipeInfoPresentationLogic {
    typealias Model = RecipeInfoModel
    func showRecipe(_ response: RecipeInfo)
    func presentRecipes(_ response: Model.Start.Response, _ data: Data?)
    func presentNutr(_ response: [String])
    func presentImage(data: Data?)
}

protocol RecipeInfoDisplayLogic: AnyObject {
    typealias Model = RecipeInfoModel
    func displayRecipe(_ viewModel: RecipeInfo)
    func openNutritionInfo(data: [String])
    func setImage(data: Data)
}

protocol RecipeInfoRoutingLogic {
    func routeToNutritionScreen(data: [String])
}

protocol RecipeInfoWorkerLogic {
    typealias Model = RecipeInfoModel
    typealias MealsCompletion = (Result<Model.Start.Response, NetworkError>) -> Void
    func getRecipeInfo(id: String, completion: @escaping MealsCompletion)
    func saveCooked(data: MainModel.Recipe.ViewModel)
    func saveFav(data: MainModel.Recipe.ViewModel)
    func saveReward(data: RewardInfo.ViewModel)
    func deleteFav(id: String)
    func deleteCooked(id: String)
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
