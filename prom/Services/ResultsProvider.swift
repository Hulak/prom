//
//  ResultsProvider.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit
import IGListKit
import CoreData

final class ResultsProvider: NSObject {
    
    private lazy var userFetchResultController: NSFetchedResultsController<Results> = {
        let fetchRequest: NSFetchRequest<Results> = NSFetchRequest(entityName: "Results")
        
        let fetchResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataService.shared.workerContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        // Set delegate to track CoreData changes
        fetchResultController.delegate = (self as NSFetchedResultsControllerDelegate)
        
        return fetchResultController
    }()
    
    override init() {
        super.init()
        do {
            try userFetchResultController.performFetch()
        }
        catch {
            fatalError("Cannot Fetch! \(error)")
        }
    }
    func getResults() -> [ResultViewModel]? {
        guard let results = self.userFetchResultController.fetchedObjects else { return nil }
        // Here we transform and return ViewModel objects!
        return results.flatMap { ResultViewModel.fromCoreData(result: $0) }
    }
}
extension ResultsProvider: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}


