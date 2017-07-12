//
//  ProgrammingLanguage+CoreDataProperties.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import CoreData


extension ProgrammingLanguage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgrammingLanguage> {
        return NSFetchRequest<ProgrammingLanguage>(entityName: "ProgrammingLanguage")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: NSOrderedSet?

}

// MARK: Generated accessors for notes
extension ProgrammingLanguage {

    @objc(insertObject:inNotesAtIndex:)
    @NSManaged public func insertIntoNotes(_ value: ShortNote, at idx: Int)

    @objc(removeObjectFromNotesAtIndex:)
    @NSManaged public func removeFromNotes(at idx: Int)

    @objc(insertNotes:atIndexes:)
    @NSManaged public func insertIntoNotes(_ values: [ShortNote], at indexes: NSIndexSet)

    @objc(removeNotesAtIndexes:)
    @NSManaged public func removeFromNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInNotesAtIndex:withObject:)
    @NSManaged public func replaceNotes(at idx: Int, with value: ShortNote)

    @objc(replaceNotesAtIndexes:withNotes:)
    @NSManaged public func replaceNotes(at indexes: NSIndexSet, with values: [ShortNote])

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: ShortNote)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: ShortNote)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSOrderedSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSOrderedSet)

}
