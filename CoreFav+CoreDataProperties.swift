//
//  CoreFav+CoreDataProperties.swift
//  FridgeRecipes
//
//  Created by Ksenia Petrova on 17.04.2023.
//
//

import Foundation
import CoreData


extension CoreFav {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreFav> {
        return NSFetchRequest<CoreFav>(entityName: "CoreFav")
    }

    @NSManaged public var idFav: String
    @NSManaged public var titleFav: String
    @NSManaged public var linkFav: URL

}

extension CoreFav : Identifiable {

}
