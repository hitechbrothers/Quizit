//
//  Category+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego Acevedo on 9/19/21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    
    @NSManaged public var name: String?
    public var wrappedName: String {
        name ?? "Unknown Category"
    }
    
    @NSManaged public var records: NSSet?
    public var recordArray: [Record] {
        let set = records as? Set<Record> ?? []
        return set.sorted {
            $0.wrappedQuestion < $1.wrappedQuestion
        }
    }
}

// MARK: Generated accessors for record
extension Category {

    @objc(addRecordObject:)
    @NSManaged public func addToRecord(_ value: Record)

    @objc(removeRecordObject:)
    @NSManaged public func removeFromRecord(_ value: Record)

    @objc(addRecord:)
    @NSManaged public func addToRecord(_ values: NSSet)

    @objc(removeRecord:)
    @NSManaged public func removeFromRecord(_ values: NSSet)

}

extension Category: BaseModel, Identifiable {

}
