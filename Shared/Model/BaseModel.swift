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
    static func all<T: NSManagedObject>(orderBy attrName: String?, ascending: Bool) -> [T]
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
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {

        do {
            return try viewContext.existingObject(with: id) as? T
        }
        catch {
            print(error)
            return nil
        }
    }
    
    static func all<T>(orderBy attrName: String? = nil, ascending: Bool = true) -> [T] where T: NSManagedObject {
        
        /* Delete this stuff later
         
        // someDate would be a date object that represents the movie's max age
        //    let oldMoviesPredicate = NSPredicate(format: "%K <= %@", #keyPath(Movie.releaseDate), someDate as NSDate)
        
        //    @FetchRequest(
        //        entity: Tag.entity(),
        //        sortDescriptors: [
        //            NSSortDescriptor(keyPath: \Tag.name, ascending: true),
        ////            animation: .default
        //        ],
        ////        predicate: NSPredicate(format: "name = %@ && school = %@", "Tom", school)
        //        predicate: NSPredicate(format: "name = %@", "Holy Spirit")
        //    ) var tags: FetchedResults<Tag>
        
        //    @FetchRequest(
        //        entity: Tag.entity(),
        //        sortDescriptors: [
        //            NSSortDescriptor(keyPath: \Tag.name, ascending: true),
        //        ],
        //        predicate: NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Tag.name), "A")
        //    ) var tags: FetchedResults<Tag>
        
        //    @FetchRequest(
        //        entity: Record.entity(),
        //        sortDescriptors: [NSSortDescriptor(keyPath: \Record.question, ascending: true)],
        ////        predicate: NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Record.question), "A"),
        ////        predicate: NSPredicate(format: "%K category.name == %@", #keyPath(Category.name), "Test 1"),
        //        predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), "Test 1"),
        ////        predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!),
        //        animation: .default
        //    ) var records: FetchedResults<Record>
        
        
        //    let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        
        //    let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        
        //    let fetchRequest = NSFetchRequest<Tag>(entityName: "Tag")
        //    let fetchRequestPredicate = NSPredicate(format: "name == %@", "Angel")
         
         //    @FetchRequest(
         //        entity: Record.entity(),
         //        sortDescriptors: [NSSortDescriptor(keyPath: \Record.question, ascending: true)],
         ////        predicate: NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Record.question), "A"),
         ////        predicate: NSPredicate(format: "%K category.name == %@", #keyPath(Category.name), "Test 1"),
         //        predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), "Test 1"),
         ////        predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!),
         //        animation: .default
         //    ) var records: FetchedResults<Record>
         //
         ////        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
         ////        let sort = NSSortDescriptor(keyPath: \Record.question, ascending: true)
         ////        fetchRequest.sortDescriptors = [sort]
         
         
         //let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
         //                    let sort = NSSortDescriptor(keyPath: \Record.question, ascending: true)
         //                    fetchRequest.sortDescriptors = [sort]
         //                    fetchRequest.predicate = NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!)
         //let records = try? viewContext.fetch(fetchRequest)
         
         @FetchRequest(
         entity: Record.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Record.question, ascending: true)],
         //        predicate: NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Record.question), "A"),
         //        predicate: NSPredicate(format: "%K category.name == %@", #keyPath(Category.name), "Test 1"),
         predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), "Test 1"),
         //        predicate: NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!),
         animation: .default
         ) var records: FetchedResults<Record>
         
         //                        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
         //                        let records = try? viewContext.fetch(fetchRequest)
         //                        let tag = tags?.randomElement()
         //                        let tag = tags.randomElement()
        */
                
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        let sort = NSSortDescriptor(key: attrName, ascending: ascending)
        fetchRequest.sortDescriptors = [sort]
//        fetchRequest.predicate = NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!)
        
        
//        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
//        //                    let sort = NSSortDescriptor(keyPath: \Record.question, ascending: true)
//        //                    fetchRequest.sortDescriptors = [sort]
//        //                    fetchRequest.predicate = NSPredicate(format: "%K LIKE %@", #keyPath(Record.category.name), category.name!)
//        let records = try? viewContext.fetch(fetchRequest)
        
        do {
            return try viewContext.fetch(fetchRequest)
        }
        catch {
            return []
        }
    }
}
