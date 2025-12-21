//
//  BaseModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/10/21.
//

import Foundation
import CoreData

protocol BaseModel where Self: NSManagedObject {
    
    func save()
    func delete()
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    static func getByUUID<T: NSManagedObject>(with id: UUID?) -> T?
    static func all<T: NSManagedObject>(orderBy attrName: String?, predicate: NSPredicate?, ascending: Bool) -> [T]
}

extension BaseModel {
    
    static var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.viewContext
    }
    
    func save() {
        
        do {
            try Self.viewContext.save()
        }
        catch {
            Self.viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func delete() {
        Self.viewContext.delete(self)
        save()
    }
    
    func getActiveTagName() -> String {
        let defaults = UserDefaults.standard
        var tagName: String = ""
        
        if let uuid_string = defaults.string(forKey: "tag_uuid") {
            let tag: Tag? = Tag.getByUUID(with: UUID(uuidString: uuid_string))
            tagName = tag!.name ?? "empty"
        }
        
        return tagName
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {

        do {
            return try viewContext.existingObject(with: id) as? T
        }
        catch {
            print(error)
            return nil
        }
    }
    
    static func getByUUID<T: NSManagedObject>(with id: UUID?) -> T? {
        guard let id = id else { return nil }
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let items = try? viewContext.fetch(request) else { return nil }
        return items.first
    }
    
    static func all<T>(orderBy attrName: String? = nil, predicate: NSPredicate? = nil, ascending: Bool = true) -> [T] where T: NSManagedObject {
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        let sort = NSSortDescriptor(key: attrName, ascending: ascending)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = predicate

        do {
            return try viewContext.fetch(fetchRequest)
        }
        catch {
            return []
        }
    }
}
