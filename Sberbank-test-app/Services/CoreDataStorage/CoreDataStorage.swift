//
//  CoreDataStorage.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStorageInterface: class {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
    func insert(original: String, translate: String, direction: String)
    func fetch<T: NSManagedObject>(objectType: T.Type, search: String?, completion: @escaping OptionalItemClosure<[T]>)
    func deleteAll()
}

class CoreDataStorage {
    
    // MARK: Static properties
    
    static let shared = CoreDataStorage()
    
    // MARK: Init

    private init() {}
    
    // MARK: Public properties
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ApplicationDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    // MARK: Private methods
    
    private func mainContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func isFetch(by translate: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest = History.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "translate == %@", translate)
        fetchRequest.fetchBatchSize = 1
        return (try? context.fetch(fetchRequest).first) != nil
    }
}

// MARK: Extensions CoreDataStorageInterface

extension CoreDataStorage: CoreDataStorageInterface {
    func saveContext() {
        let context = mainContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
        
    func insert(original: String, translate: String, direction: String) {
        persistentContainer.performBackgroundTask {[weak self] backgroundContext in
            guard let self = self else { return }
            guard !self.isFetch(by: translate, context: backgroundContext) else { return }
            let history = History(context: backgroundContext)
            history.original = original
            history.translate = translate
            history.direction = direction
            try? backgroundContext.save()
        }
    }
        
    func fetch<T: NSManagedObject>(objectType: T.Type, search: String? = nil, completion: @escaping OptionalItemClosure<[T]>) {
        persistentContainer.performBackgroundTask {[weak self] backgroundContext in
            guard let self = self else { return }
            let fetchRequest: NSFetchRequest = T.fetchRequest()
            if let search = search {
                fetchRequest.predicate = NSPredicate(format: "original CONTAINS[cd] %@ OR translate CONTAINS[cd] %@", search, search)
            }
            if let result = try? backgroundContext.fetch(fetchRequest) as? [T] {
                let mainContext = self.mainContext()
                if let mainResults = result.map({mainContext.object(with: $0.objectID)}) as? [T] {
                    DispatchQueue.main.async { completion(mainResults) }
                    return
                }
            }
            DispatchQueue.main.async { completion(nil) }
        }
    }
    
    
    func deleteAll() {
        persistentContainer.performBackgroundTask { backgroundContext in
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = History.fetchRequest()
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _ = try? backgroundContext.execute(batchDeleteRequest)
            try? backgroundContext.save()
        }
    }
}
