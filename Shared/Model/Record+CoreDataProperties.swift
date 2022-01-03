//
//  Record+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego Acevedo on 9/19/21.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var answer: String?
    public var wrappedAnswer: String {  //wrap property to work with swiftui
            answer ?? "Unknown Answer"
        }
    @NSManaged public var id: UUID?
    @NSManaged public var question: String?
    public var wrappedQuestion: String {
            question ?? "Unknown Question"
        }
    @NSManaged public var category: Category?
    @NSManaged public var tags: Tag?
}

// MARK: Generated accessors for tag
extension Record {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: Tag)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: Tag)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}

extension Record: BaseModel, Identifiable {

}
