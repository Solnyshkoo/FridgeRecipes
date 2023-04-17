import UIKit

final class RecipeInfoRouter: RecipeInfoRoutingLogic {
    weak var view: UIViewController?

    func routeToNutritionScreen(data: [String]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let vc = NutritionAssembly.build(data: data)
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.prefersGrabberVisible = true
            }

            self.view?.present(vc, animated: true, completion: nil)
        }
    }
}
