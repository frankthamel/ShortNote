//
//  UserAuthentication.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData

class UserAuthentication {
    class func authenticate(user : String , encryptedPassword : String, managedContext : NSManagedObjectContext ) -> (status : Bool , message : String) {
        let fetch : NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(User.username), user)
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                let currentUser = results.first
                if let loggedUser = currentUser {
                    if encryptedPassword == loggedUser.password!{
                        return(true , "")
                    } else {
                        return (false , FormValidationMessage.passwordMismatch.rawValue)
                    }
                } else {
                    return (false , FormValidationMessage.noSuchUser.rawValue)
                }
            } else {
                return (false , FormValidationMessage.noSuchUser.rawValue)
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }

        return (false , "")
    }
}
