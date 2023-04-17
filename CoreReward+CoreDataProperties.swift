//
//  CoreReward+CoreDataProperties.swift
//  FridgeRecipes
//
//  Created by Ksenia Petrova on 17.04.2023.
//
//

import Foundation
import CoreData


extension CoreReward {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreReward> {
        return NSFetchRequest<CoreReward>(entityName: "CoreReward")
    }

    @NSManaged public var title: String
    @NSManaged public var imgString: String

}

extension CoreReward : Identifiable {

}
