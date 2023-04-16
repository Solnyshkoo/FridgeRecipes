import UIKit

final class PersonalRecipesPresenter: PersonalRecipesPresentationLogic {
    
    weak var view: PersonalRecipesDisplayLogic?
    
    func presentRecipes(_ response: Model.Recipe.Response) {
        view?.displayRecipes(parseResponse(data: response))
    }
    
    private func parseResponse(data: MainModel.Recipe.Response) -> [MainModel.Recipe.ViewModel] {
        var parseData: [MainModel.Recipe.ViewModel] = []
        data.meals.forEach { item in
            parseData.append(MainModel.Recipe.ViewModel(id: item.id ?? "", titleText: item.name, thumbnailLink: item.thumbnailLink))
        }
        
        return parseData
    }
}

