
import UIKit

final class NutritionPresenter: NutritionPresentationLogic {
    weak var view: NutritionDisplayLogic?

    // MARK: - PresentationLogic

    func presentNutritionInfo(_ response: Model.Response, show: Bool) {
        if show {
            view?.displayInfo(parseData(data: response))
        } else {
            view?.addInfo(parseData(data: response))
        }
    }

    private func parseData(data: Model.Response) -> NutritionModel.ViewModel {
        let k = NutritionModel.ViewModel(
            calorie: data.calories,
            all: [
                data.totalNutrients["FAT"],
                data.totalDaily["FAT"],
                data.totalNutrients["FASAT"],
                data.totalDaily["FASAT"],
                data.totalNutrients["FATRN"],
                data.totalDaily["FATRN"],
                data.totalNutrients["CHOLE"],
                data.totalDaily["CHOLE"],
                data.totalNutrients["NA"],
                data.totalDaily["NA"],
                data.totalNutrients["CHOCDF"],
                data.totalDaily["CHOCDF"],
                data.totalNutrients["FIBTG"],
                data.totalDaily["FIBTG"],
                data.totalNutrients["SUGAR"],
                data.totalDaily["SUGAR"],
                data.totalNutrients["PROCNT"],
                data.totalDaily["PROCNT"],
                data.totalNutrients["VITD"],
                data.totalDaily["VITD"],
                data.totalNutrients["CA"],
                data.totalDaily["CA"],
                data.totalNutrients["FE"],
                data.totalDaily["FE"],
                data.totalNutrients["K"],
                data.totalDaily["K"],
            ],
            cellId: [
                "main",
                "info",
                "info",
                "main",
                "main",
                "main",
                "info",
                "info",
                "main",
                "main",
                "main",
                "main",
                "main",
            ])

        return k
    }

    func presentError(error: String) {
        view?.displayError(error: "s")
    }
}
