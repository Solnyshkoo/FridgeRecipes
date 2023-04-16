import UIKit

final class RecipesPresenter: RecipesPresentationLogic {
    weak var view: RecipesDisplayLogic?
    
    func presentRecipes(_ response: Model.Recipe.Response, showNew: Bool) {
        view?.displayRecipes(parseResponse(data: response), showNew: showNew)
    }
    
    private func parseResponse(data: MainModel.Recipe.Response) -> [MainModel.Recipe.ViewModel] {
        var parseData: [MainModel.Recipe.ViewModel] = []
        data.meals.forEach { item in
            parseData.append(MainModel.Recipe.ViewModel(id: item.id ?? "", titleText: item.name, thumbnailLink: item.thumbnailLink))
        }
        
        return parseData
    }
    
    func addRecipes(_ response: Model.Recipe.Response) {
        view?.displayAdditionalRecipes(parseResponse(data: response))
    }
    
    func presentNothing() {
        view?.displayNothingFound()
    }
}

