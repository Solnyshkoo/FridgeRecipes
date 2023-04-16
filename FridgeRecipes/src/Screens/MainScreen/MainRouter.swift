import UIKit

final class MainRouter: MainRoutingLogic {
    weak var view: UIViewController?

    func routeToRecipesScreen(data: RequestType, titleText: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(RecipesAssembly.build(data: data, titleText: titleText), animated: true)
        }
    }
    
    func routeToStories() {
        let vc = StoriesViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        self.view?.present(vc, animated: false, completion: nil)
    }
}

