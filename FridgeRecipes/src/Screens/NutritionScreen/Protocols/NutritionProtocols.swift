import Foundation
protocol NutritionBusinessLogic {
    typealias Model = NutritionModel
    func loadNutritionInfo(_ request: Model.Request)
}

protocol NutritionPresentationLogic {
    typealias Model = NutritionModel
    func presentNutritionInfo(_ response: Model.Response)
}

protocol NutritionDisplayLogic: AnyObject {
    typealias Model = NutritionModel
    func displayRecipe(_ viewModel: Model.ViewModel)
}

protocol NutritionWorkerLogic {
    typealias Model = NutritionModel
    typealias NutritionCompletion = (Result< Model.Response, NetworkError>) -> Void
    func getNutritionInfo(id: String, completion: @escaping NutritionCompletion)
    
}
