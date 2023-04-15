import UIKit

final class MainRouter: MainRoutingLogic {
    weak var view: UIViewController?

    func routeToRecipesScreen(data: MainModel.Recipe.Request) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(RecipesAssembly.build(data: data), animated: true)
        }
    }
}

