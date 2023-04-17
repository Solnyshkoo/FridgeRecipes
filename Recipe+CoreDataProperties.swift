//
//  Recipe+CoreDataProperties.swift
//  FridgeRecipes
//
//  Created by Ksenia Petrova on 17.04.2023.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: String
    @NSManaged public var titleText: String
    @NSManaged public var thumbnailLink: URL

}

extension Recipe : Identifiable {

}
