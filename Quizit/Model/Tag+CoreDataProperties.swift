//
//  Tag+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/6/21.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var record: Record?

}

extension Tag : Identifiable {

}
