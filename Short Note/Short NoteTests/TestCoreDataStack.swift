//
//  TestCoreDataStack.swift
//  Short Note
//
//  Created by frank thamel on 7/14/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData
@testable import Short_Note

class TestCoreDataStack: CoreDataStack {
    convenience init() {
        self.init(modelName : "ShortNoteDataModel")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        let persistanceStoreDescription = NSPersistentStoreDescription()
        persistanceStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistanceStoreDescription]
        
        container.loadPersistentStores {
            (storeDescription , error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.storeContainer = container
    }
}
