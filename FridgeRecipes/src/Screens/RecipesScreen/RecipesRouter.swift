import UIKit

final class RecipesRouter: RecipesRoutingLogic {
    func routeToRecipeInfoScreen(data: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(RecipeInfoAssembly.build(data: data), animated: true)
        }
    }

    weak var view: UIViewController?

    func routeTo() {}
}
