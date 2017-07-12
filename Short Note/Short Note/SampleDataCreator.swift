//
//  SampleDataCreator.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData


class SampleDataCreator {
    
    private static let sampleProgrammingLanguages : [String] = ["Swift" , "Java" , "Angular" , "C#" , "Objective C" , "ROR" , "HTML" , "CSS" , "Java Script"]
    
    class func insertSampleData(managedContext : NSManagedObjectContext) {

        let fetch : NSFetchRequest<ProgrammingLanguage> = ProgrammingLanguage.fetchRequest()
        
        do {
            let count = try managedContext.count(for: fetch)
            if count > 0 {
                return
            }
            
            for data in sampleProgrammingLanguages {
                let entity = ProgrammingLanguage(context: managedContext)
                entity.name = data
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
