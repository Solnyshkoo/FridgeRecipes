import Foundation
protocol NutritionBusinessLogic {
    typealias Model = NutritionModel
    func loadNutritionInfo(_ request: Model.Start.Request)
}

protocol NutritionPresentationLogic {
    typealias Model = NutritionModel
    func presentNutritionInfo(_ response: Model.Start.Response)
}

protocol NutritionDisplayLogic: AnyObject {
    typealias Model = NutritionModel
    func displayRecipe(_ viewModel: Model.Start.ViewModel)
}

protocol NutritionWorkerLogic {
    typealias Model = NutritionModel
    typealias NutritionCompletion = (Result< Model.Start.Response, NetworkError>) -> Void
    func getNutritionInfo(id: String, completion: @escaping NutritionCompletion)
    
}
