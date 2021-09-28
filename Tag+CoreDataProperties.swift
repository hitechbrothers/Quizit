//
//  Tag+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego Acevedo on 9/19/21.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var record: NSSet?

}

// MARK: Generated accessors for record
extension Tag {

    @objc(addRecordObject:)
    @NSManaged public func addToRecord(_ value: Record)

    @objc(removeRecordObject:)
    @NSManaged public func removeFromRecord(_ value: Record)

    @objc(addRecord:)
    @NSManaged public func addToRecord(_ values: NSSet)

    @objc(removeRecord:)
    @NSManaged public func removeFromRecord(_ values: NSSet)

}

extension Tag : Identifiable {

}
