import Foundation
protocol PersonalBusinessLogic {
    func loadUserInfo()
    func changeValue()
}

protocol PersonalPresentationLogic {
    typealias Model = RecipeInfoModel
    func updatePersonalView()
}

protocol PersonalDisplayLogic: AnyObject {
    typealias Model = RecipeInfoModel
    func updatePersonalData()
}

protocol ChangePersonalDisplayLogic: AnyObject {}

protocol PersonalRoutingLogic {
    func routeToChangePersonalInfoScreen(interactor: PersonalBusinessLogic)
    func routeToCookedRecipesScreen(data: [MainModel.Recipe.ViewModel])
    func routeToFavoriteRecilesScreen(data: [MainModel.Recipe.ViewModel])
    func routeToRewards(interactor: PersonalBusinessLogic)
    func routeToNutritionScreen(data: [String])
}

protocol PersonalWorkerLogic {
    func getUserInfo()
    func saveUserInfo()
}
