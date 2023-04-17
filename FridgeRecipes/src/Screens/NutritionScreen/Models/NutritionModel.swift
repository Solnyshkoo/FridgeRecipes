import UIKit

enum NutritionModel {
    // MARK: Use cases

    struct Request {
        let text: [String]
    }

    struct Response: Codable {
        let uri: String
        let calories, totalWeight: Int
        let totalNutrients, totalDaily: [String: TotalDaily]
        let totalNutrientsKCal: TotalNutrientsKCal
    }

    struct ViewModel {
        var calorie: Int
        var all: [TotalDaily?]
        var cellId: [String?]

        func plus(data: NutritionModel.ViewModel) -> NutritionModel.ViewModel {
            NutritionModel.ViewModel(
                calorie: self.calorie + data.calorie,
                all: [
                    self.createTotalDaily(data: self.all[0], data2: data.all[0]),
                    self.createTotalDaily(data: self.all[1], data2: data.all[1]),
                    self.createTotalDaily(data: self.all[2], data2: data.all[2]),
                    self.createTotalDaily(data: self.all[3], data2: data.all[3]),
                    self.createTotalDaily(data: self.all[4], data2: data.all[4]),
                    self.createTotalDaily(data: self.all[5], data2: data.all[5]),
                    self.createTotalDaily(data: self.all[6], data2: data.all[6]),
                    self.createTotalDaily(data: self.all[7], data2: data.all[7]),
                    self.createTotalDaily(data: self.all[8], data2: data.all[8]),
                    self.createTotalDaily(data: self.all[9], data2: data.all[9]),
                    self.createTotalDaily(data: self.all[10], data2: data.all[10]),
                    self.createTotalDaily(data: self.all[11], data2: data.all[11]),
                    self.createTotalDaily(data: self.all[12], data2: data.all[12]),
                    self.createTotalDaily(data: self.all[13], data2: data.all[13]),
                    self.createTotalDaily(data: self.all[14], data2: data.all[14]),
                    self.createTotalDaily(data: self.all[15], data2: data.all[15]),
                    self.createTotalDaily(data: self.all[16], data2: data.all[16]),
                    self.createTotalDaily(data: self.all[17], data2: data.all[17]),
                    self.createTotalDaily(data: self.all[18], data2: data.all[18]),
                    self.createTotalDaily(data: self.all[19], data2: data.all[19]),
                    self.createTotalDaily(data: self.all[20], data2: data.all[20]),
                    self.createTotalDaily(data: self.all[21], data2: data.all[21]),
                    self.createTotalDaily(data: self.all[22], data2: data.all[22]),
                    self.createTotalDaily(data: self.all[23], data2: data.all[23]),
                    self.createTotalDaily(data: self.all[24], data2: data.all[24]),
                    self.createTotalDaily(data: self.all[25], data2: data.all[25])
                ],
                cellId: self.cellId
            )
        }

        private func createTotalDaily(data: TotalDaily?, data2: TotalDaily?) -> TotalDaily? {
            TotalDaily(
                label: data?.label ?? "",
                quantity: (data?.quantity ?? 0.0) + (data2?.quantity ?? 0.0),
                unit: data?.unit ?? Unit.g
            )
        }
    }
}

import Foundation

// MARK: - Response

struct ResponseNutritions: Codable {
    let uri: String
    let calories, totalWeight: Int
    let totalNutrients, totalDaily: [String: TotalDaily]
    let totalNutrientsKCal: TotalNutrientsKCal
}

// MARK: - Ingredient

struct IngredientNutro: Codable {
    let text: String
    let parsed: [Parsed]
}

// MARK: - Parsed

struct Parsed: Codable {
    let quantity: Double
    let measure, foodMatch, food, foodID: String
    let weight, retainedWeight: Int
    let nutrients: [String: TotalDaily]
    let measureURI: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case quantity, measure, foodMatch, food
        case foodID = "foodId"
        case weight, retainedWeight, nutrients, measureURI, status
    }
}

// MARK: - TotalDaily

struct TotalDaily: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}

enum Unit: String, Codable {
    case empty = "%"
    case g
    case iu = "IU"
    case kcal
    case mg
    case µg
}

// MARK: - TotalNutrientsKCal

struct TotalNutrientsKCal: Codable {
    let enercKcal, procntKcal, fatKcal, chocdfKcal: TotalDaily

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case procntKcal = "PROCNT_KCAL"
        case fatKcal = "FAT_KCAL"
        case chocdfKcal = "CHOCDF_KCAL"
    }
}
