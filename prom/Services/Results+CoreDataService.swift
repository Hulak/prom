//
//  Results+CoreDataService.swift
//  prom
//
//  Created by Alyona Hulak on 11/16/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataService {
    
    var results: [Results]? {
        let moc = CoreDataService.shared.persistentContainer.viewContext
        
        do {
            let request: NSFetchRequest<Results> = Results.fetchRequest()
            let results = try moc.fetch(request)
            if !results.isEmpty {
                return results
            }
        } catch {
            assertionFailure("Failed to fetch users: \(error)")
        }
        return nil
    }
    
    func result() -> Results? {
        let moc = CoreDataService.shared.persistentContainer.viewContext
        
        do {
            let request: NSFetchRequest<Results> = Results.fetchRequest()
            let result = try moc.fetch(request)
            if !result.isEmpty {
                return result.first
            }
        } catch {
            assertionFailure("Failed to fetch users: \(error)")
        }
        return nil
    }
}
