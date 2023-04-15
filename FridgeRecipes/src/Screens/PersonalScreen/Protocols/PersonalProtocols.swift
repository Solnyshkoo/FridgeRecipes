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

protocol ChangePersonalDisplayLogic: AnyObject {
    
}
protocol PersonalRoutingLogic {
    func routeToChangePersonalInfpScreen(interactor: PersonalBusinessLogic)
}

protocol PersonalWorkerLogic {
    func getUserInfo()
    func saveUserInfo()
}
