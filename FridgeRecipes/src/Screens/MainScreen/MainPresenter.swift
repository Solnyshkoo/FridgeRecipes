import UIKit

final class MainPresenter: MainPresentationLogic {
    // MARK: - Constants
    private enum Constants {

    }

    weak var view: MainDisplayLogic?

    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
    }

    func presentAction(_ response: Model.Action.Response) {
    }
    
//    func presentRecipes(_ response: Model.Recipe.Response) {
//        view?.displayRecipes(parseResponse(data: response))
//    }
    
    private func parseResponse(data: MainModel.Recipe.Response) -> [MainModel.Recipe.ViewModel] {
        var parseData: [MainModel.Recipe.ViewModel] = []
        data.meals.forEach { item in
            parseData.append(MainModel.Recipe.ViewModel(id: item.id ?? "", titleText: item.name, thumbnailLink: item.thumbnailLink))
        }
        
        return parseData
        
    }
}
