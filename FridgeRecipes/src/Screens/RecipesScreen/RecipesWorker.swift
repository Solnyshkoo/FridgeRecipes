//
//  RecipesWorker.swift
//  FridgeRecipes
//
//  Created by Ksenia Petrova on 03.04.2023.
//

import Foundation

final class RecipesWorker: RecipesWorkerLogic {
    func doSomething() {
    }
    
     let service: NetworkRecipesServiceProtocol
    
     init(service: NetworkRecipesServiceProtocol) {
         self.service = service
     }
}
