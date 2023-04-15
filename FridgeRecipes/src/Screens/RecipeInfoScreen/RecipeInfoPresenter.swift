import UIKit

final class RecipeInfoPresenter: RecipeInfoPresentationLogic {
    
    // MARK: - Constants
    private enum Constants {

    }

    weak var view: RecipeInfoDisplayLogic?
    
    func showRecipe(_ response: RecipeInfo) {
        view?.displayRecipe(response)
    }
    
    func presentRecipes(_ response: Model.Start.Response) {
        guard let recipe = response.meals.first else {
            return
            
        }
        view?.displayRecipe(recipe)
    }
    
}
