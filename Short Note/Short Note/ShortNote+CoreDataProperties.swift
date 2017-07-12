//
//  ShortNote+CoreDataProperties.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData


extension ShortNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShortNote> {
        return NSFetchRequest<ShortNote>(entityName: "ShortNote")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var imageOne: NSData?
    @NSManaged public var imageTwo: NSData?
    @NSManaged public var imageThree: NSData?
    @NSManaged public var imageFour: NSData?
    @NSManaged public var imageFive: NSData?
    @NSManaged public var language: ProgrammingLanguage?

}
