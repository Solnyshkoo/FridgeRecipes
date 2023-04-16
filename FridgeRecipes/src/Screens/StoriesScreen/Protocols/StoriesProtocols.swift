import Foundation
protocol StoriesBusinessLogic {
    typealias Model = StoriesModels
    func loadNutritionInfo(_ request: Model.Request)
}

protocol StoriesPresentationLogic {
    typealias Model = StoriesModels
    func presentNutritionInfo(_ response: Model.Response)
}

protocol StoriesDisplayLogic: AnyObject {
    typealias Model = StoriesModels
    func displayRecipe(_ viewModel: Model.ViewModel)
}

