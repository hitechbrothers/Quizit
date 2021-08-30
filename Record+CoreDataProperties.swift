//
//  Record+CoreDataProperties.swift
//  Quizit
//
//  Created by Diego Acevedo on 3/21/21.
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
    @NSManaged public var tag: Tag?
}

extension Record : Identifiable {

}
