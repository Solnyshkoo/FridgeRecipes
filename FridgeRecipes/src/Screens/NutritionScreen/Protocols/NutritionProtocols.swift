import Foundation
protocol NutritionBusinessLogic {
    typealias Model = NutritionModel
    func loadNutritionInfo(_ request: Model.Request)
}

protocol NutritionPresentationLogic {
    typealias Model = NutritionModel
    func presentNutritionInfo(_ response: Model.Response, show: Bool)
    func presentError(error: String)
}

protocol NutritionDisplayLogic: AnyObject {
    typealias Model = NutritionModel
    func displayInfo(_ viewModel: Model.ViewModel)
    func addInfo(_ viewModel: Model.ViewModel)
    func displayError(error: String)
}

protocol NutritionWorkerLogic {
    typealias Model = NutritionModel
    typealias NutritionCompletion = (Result<Model.Response, NetworkError>) -> Void
    func getNutritionInfo(id: String, completion: @escaping NutritionCompletion)
}
