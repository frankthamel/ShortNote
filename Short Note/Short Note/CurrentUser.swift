//
//  CurrentUser.swift
//  Short Note
//
//  Created by frank thamel on 7/13/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData

class CurrentUser {
   class func find(username : String , managedContext : NSManagedObjectContext ) -> User? {
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(User.username), username)
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                let currentUser = results.first
                return currentUser
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    
        return nil
    }
}
