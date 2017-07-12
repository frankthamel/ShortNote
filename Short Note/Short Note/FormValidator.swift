//
//  FormValidator.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum FormValidationMessage : String {
    case empty = "can not be blank."
    case noSuchUser = "Invalid username."
    case usernameTaken = "Username already taken."
    case passwordMismatch = "Wrong username/password."
    case passwordConfirmMismatch = "Password/Confirm Password mismatch."
}

class FormValidator {
    
    // check fields
    class func isEmptyField(_ field : String? , withName name : String) -> (status : Bool, message : String) {
        let message = "\(name) \(FormValidationMessage.empty.rawValue)"
        if let field = field {
            return (field.isEmpty , message)
        } else {
            return (true , message)
        }
    }
    
    // check passwprd and confirm password
    class func passwordMismatch(password : String , confirmPassword : String) -> (status : Bool, message : String) {
        let message = "\(FormValidationMessage.passwordConfirmMismatch.rawValue)"
        if password != confirmPassword {
            return (true , message)
        } else {
            return (false , "")
        }
    }
    
    //  check username alredy used
    class func usernameTaken(username : String , managedContext : NSManagedObjectContext) -> (status : Bool, message : String) {
        let fetch : NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(User.username), username)
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                return (true , FormValidationMessage.usernameTaken.rawValue)
            } else {
                return (false , "")
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        return (false , "")
    }
}
