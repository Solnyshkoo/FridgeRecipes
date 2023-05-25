import UIKit

final class RecipeInfoPresenter: RecipeInfoPresentationLogic {

    weak var view: RecipeInfoDisplayLogic?

    func showRecipe(_ response: RecipeInfo) {
        view?.displayRecipe(response)
    }

    func presentRecipes(_ response: Model.Start.Response, _ data: Data?) {
        var recipe = response.meals.first
        recipe?.data = data
        guard let recipe = response.meals.first else {
            return
        }
       
        view?.displayRecipe(recipe)
    }

    func presentNutr(_ response: [String]) {
        view?.openNutritionInfo(data: response)
    }
    
    func presentImage(data: Data?) {
        guard let data = data else { return }
        view?.setImage(data: data)
    }
}
