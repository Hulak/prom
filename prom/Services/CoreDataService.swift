//
//  CoreDataService.swift
//  prom
//
//  Created by Alyona Hulak on 11/15/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {
    }
    
    lazy private(set) var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "prom")
        container.loadPersistentStores() { (description, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    // MARK: - Core Data Stack
    
    private(set) lazy var privateContext: NSManagedObjectContext = {
        return CoreDataService.shared.persistentContainer.newBackgroundContext()
    }()
    
    private(set) lazy var mainContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateContext
        return managedObjectContext
    }()
    
    private(set) lazy var workerContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = self.mainContext
        return managedObjectContext
    }()
    
    
    // MARK: - Notification Handling
    
    @objc private func saveChanges(_ notification: NSNotification) {
        saveWorkerContext()
    }
    
    func saveWorkerContextAndWait() {
        saveAndWait(context: workerContext) {
            self.saveAndWait(context: self.mainContext, completion: {
                self.saveAndWait(context: self.privateContext, completion: nil)
            })
        }
    }
    
    func saveWorkerContext() {
        save(context: workerContext) {
            self.save(context: self.mainContext, completion: {
                self.save(context: self.privateContext, completion: nil)
            })
        }
    }
    
    func save(context: NSManagedObjectContext, completion: (() -> Void)?) {
        context.perform {
            do {
                if context.hasChanges {
                    try context.save()
                    if let completion = completion {
                        completion()
                    }
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        }
    }
    
    func saveAndWait(context: NSManagedObjectContext, completion: (() -> Void)?) {
        context.performAndWait {
            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        }
        if let completion = completion {
            completion()
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
