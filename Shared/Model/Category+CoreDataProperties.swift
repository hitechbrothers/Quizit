//
//  Category+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego on 9/29/22.
//
//

import Foundation
import CoreData


extension Category {
    
//    @NSManaged public var id: UUID?
//    @NSManaged public var name: String?
//    public var wrappedName: String {
//        name ?? "Unknown Category"
//    }
//    @NSManaged public var records: NSSet?
//    public var recordArray: [Record] {
//        let set = records as? Set<Record> ?? []
//        return set.sorted {
//            $0.wrappedQuestion < $1.wrappedQuestion
//        }
//    }
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
//        return NSFetchRequest<Category>(entityName: "Category")
//    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var records: NSSet?
}

// MARK: Generated accessors for records
extension Category {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: Record)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: Record)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}

extension Category : BaseModel, Identifiable {

}
