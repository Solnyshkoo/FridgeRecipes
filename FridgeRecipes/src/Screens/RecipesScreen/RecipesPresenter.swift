import UIKit

final class RecipesPresenter: RecipesPresentationLogic {
    // MARK: - Fields

    weak var view: RecipesDisplayLogic?
    
    // MARK: - Present Recipes

    func presentRecipes(_ response: Model.Recipe.Response, showNew: Bool) {
        view?.displayRecipes(parseResponse(data: response), showNew: showNew)
    }
    
    // MARK: - Add Recipes

    func addRecipes(_ response: Model.Recipe.Response) {
        view?.displayAdditionalRecipes(parseResponse(data: response))
    }
    
    // MARK: - Nothing found

    func presentNothing() {
        view?.displayNothingFound()
    }
    
    // MARK: - Parse response

    private func parseResponse(data: MainModel.Recipe.Response) -> [MainModel.Recipe.ViewModel] {
        var parseData: [MainModel.Recipe.ViewModel] = []
        data.meals.forEach { item in
            parseData.append(MainModel.Recipe.ViewModel(id: item.id ?? "", titleText: item.name, thumbnailLink: item.thumbnailLink))
        }
        
        return parseData
    }
}
