import UIKit

final class RecipesPresenter: RecipesPresentationLogic {
    
    private let recipes: [MainModel.Recipe.ViewModel]
    
    weak var view: RecipesDisplayLogic? {
        didSet {
            view?.displayRecipes(recipes)
        }
    }
    
    init(data: [MainModel.Recipe.ViewModel]) {
        self.recipes = data
    }
}

