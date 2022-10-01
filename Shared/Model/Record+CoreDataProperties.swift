//
//  Record+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego on 9/29/22.
//
//

import Foundation
import CoreData


extension Record {
    
//    @NSManaged public var answer: String?
//    public var wrappedAnswer: String {  //wrap property to work with swift
//        answer ?? "Unknown Answer"
//    }
//    @NSManaged public var id: UUID?
//    @NSManaged public var question: String?
//    public var wrappedQuestion: String {
//        question ?? "Unknown Question"
//    }
//    @NSManaged public var category: Category?
//    @NSManaged public var tags: Tag?
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
//        return NSFetchRequest<Record>(entityName: "Record")
//    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var answer: String?
    @NSManaged public var id: UUID?
    @NSManaged public var question: String?
    @NSManaged public var category: Category?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension Record {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension Record : BaseModel, Identifiable {

}
