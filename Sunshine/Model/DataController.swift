//
//  DataController.swift
//  Sunshine
//
//  Created by Jerry Hanks on 24/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistenceContainer : NSPersistentContainer
    
    var viewContext : NSManagedObjectContext{
        return persistenceContainer.viewContext
    }
    
    let backgroundContext:NSManagedObjectContext!
    
    
    init(modelName:String) {
        self.persistenceContainer = NSPersistentContainer(name: modelName)
        
        self.backgroundContext = persistenceContainer.newBackgroundContext()
        
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion:(()->Void)?  = nil){
        self.persistenceContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            
            //loaded
            self.configureContexts()
            
            //complete
            completion?()
        }
    }
}

// MARK: - Autosaving

extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 30) {
        print("autosaving")
        
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}

