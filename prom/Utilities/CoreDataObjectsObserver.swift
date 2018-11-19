//
//  CoreDataObjectsObserver.swift
//  prom
//
//  Created by Alyona Hulak on 11/18/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//
import Foundation
import CoreData

protocol CoreDataObjectsObserverProtocol: class {
    func objectsDidChange(objects: [NSFetchRequestResult])
    func objectsWillChange(objects: [NSFetchRequestResult])
    func object(_ object: NSFetchRequestResult, didChange anObject: NSFetchRequestResult, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    func sectionInfo(_ sectionInfo: NSFetchedResultsSectionInfo, didChangeAtSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType)
    func sectionIndexTitleForSectionName(_ sectionName: String) -> String?
}

extension CoreDataObjectsObserverProtocol {
    func objectsDidChange(objects: [NSFetchRequestResult]) {}
    func objectsWillChange(objects: [NSFetchRequestResult]) {}
    func object(_ object: NSFetchRequestResult, didChange anObject: NSFetchRequestResult, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {}
    func sectionInfo(_ sectionInfo: NSFetchedResultsSectionInfo, didChangeAtSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {}
    func sectionIndexTitleForSectionName(_ sectionName: String) -> String? {return ""}
}

class CoreDataObjectsObserver<T>: NSObject, NSFetchedResultsControllerDelegate where T:NSFetchRequestResult {
    
    //MARK: - type aliases
    typealias ObjectType = T.Type
    typealias didChangeBlock = ([T]) -> Void
    
    //MARK: - Internal properties
    weak var delegate: CoreDataObjectsObserverProtocol?
    var fetchedObjects: [T] {
        get {
            return fetchedResultsController.fetchedObjects ?? [T]()
        }
    }
    
    //MARK: - Private properties
    private var didChange: didChangeBlock?
    private let fetchRequest: NSFetchRequest<T>
    private let fetchedResultsController: NSFetchedResultsController<T>
    
    //MARK: - Initialization
    init(with fetchRequest:NSFetchRequest<T>, onChange: didChangeBlock?) {
        self.didChange = onChange
        self.fetchRequest = fetchRequest
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        
        //assign delegate for callbacks, basically this is for fututre functionality if needed
        self.fetchedResultsController.delegate = self
        
        //perform the first fetch, to have fetchedObjects available by default
        self.fetch()
    }
    
    //MARK: - NSFetchedResultsControllerDelegate
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let objects = fetchedResultsController.fetchedObjects {
            dispatchObjects(on: DispatchQueue.main, fetchedObjects: objects)
        }
    }
    
    //MARK: - Private methods
    func fetch() {
        CoreDataService.shared.mainContext.perform {[weak self] in
            try? self?.fetchedResultsController.performFetch()
            if let objects = self?.fetchedResultsController.fetchedObjects {
                self?.dispatchObjects(on: DispatchQueue.main, fetchedObjects: objects)
            }
        }
    }
    
    func dispatchObjects(on: DispatchQueue, fetchedObjects: [T]) {
        on.async { [weak self] in
            //notify via closure
            if let didChange = self?.didChange {
                didChange(fetchedObjects)
            }
            //notify via delegate
            self?.delegate?.objectsDidChange(objects: fetchedObjects)
        }
    }
}







