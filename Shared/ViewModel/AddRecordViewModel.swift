//
//  AddRecordViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 12/9/21.
//

import Foundation
import CoreData
import SwiftUI

//class AddQuestionViewModel: ObservableObject {
//
////    let category: CategoryViewModel
//
//    @Published var answer: String = ""
//    @Published var question: String = ""
//    let id: UUID = UUID()
//
////    init() {
////        self.category =
////    }
//
//    func save(category: Category) {
//
//
//        //Get the tag in UserDefaults
//        let defaults = UserDefaults.standard
//        let tag = Tag(context: Tag.viewContext)
//
//        if let savedTag = defaults.object(forKey: "savedTag") as? Data {
//            let decoder = JSONDecoder()
//            if let loadedTag = try? decoder.decode(SettingsTag.self, from: savedTag) {
//                print(loadedTag.name)
//                tag.id = UUID()
//                tag.name = loadedTag.name
//            }
//        }
//
//        // this may create multiple tags with the same name, probably not what you want
//
//        //addActorToMovie(movieId: NSManagedObjectID)
//        //let tag2: Tag? = Tag.byId(id: tag.id)
//
//        let record = Record(context: Record.viewContext)
//        record.question = self.question
//        record.answer = self.answer
//        record.id = self.id
//        record.category = category
////        record.tags = tag //needs NSSet
////        record.addToTag(tag)  //it dosen't like this probably needs tag byId use byId see MovieApp
//
//        record.save()
//    }
//}

class AddRecordViewModel: ObservableObject {
    
    var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.viewContext
    }
    
    //    let category: CategoryViewModel
    
    @Published var answer: String = ""
    @Published var question: String = ""
    let id: UUID = UUID()
    
    func save(category: Category) {
        
        
        //Get the tag in UserDefaults
        let defaults = UserDefaults.standard
//        let tag = Tag(context: Tag.viewContext)
        
//        if let savedTag_uuid = defaults.object(forKey: "tag_uuid") as? Data {
//            let decoder = JSONDecoder()
//            if let id = try? decoder.decode(SettingsTag.self, from: savedTag_uuid) {
//                print("before")
//                print(id)
//                print("after")
////                tag.id = UUID()
////                tag.name = loadedTag.name
//            }
//        }
        
//        if let uuid_data = defaults.object(forKey: "tag_uuid") as? Data {
            
        if let uuid_string = defaults.string(forKey: "tag_uuid") {

            print("before")
            print(uuid_string)
            print("after")

//            var uuid = UUID(uuidString: uuid_string)
            
            let tag: Tag? = Tag.getByUUID(with: UUID(uuidString: uuid_string))
            
            
            
            
//            let tag: Tag? = getItem(with: UUID(uuidString: uuid_string))
            
            /* test */
            let tagName: String = tag!.name!
            print(tagName)
            /* end test*/
            
            let record = Record(context: Record.viewContext)
            record.question = self.question
            record.answer = self.answer
            record.id = self.id
            record.category = category
            record.addToTags(tag!)
//            record.tags = NSSet(tag)
            
//            tag?.addToRecord(record)
            
//            record.addToTag(tag!)
            
            
//            tag?.addToRecord(record)
            
//            let tag: Tag? = Tag(context: Tag.viewContext)
//            tag?.name = "test"
//            tag?.id = UUID(uuidString: uuid_string)
//            tag?.addToRecord(record)
            
            
//            if let tag = tag {
//                //place record creation in here
//                let record = Record(context: Record.viewContext)
//                record.question = self.question
//                record.answer = self.answer
//                record.id = self.id
//                record.category = category
////                record.tags = tag
////                record.tags = tag //needs NSSet
////                record.addToTag(tag)  //it dosen't like this probably needs tag byId use byId see MovieApp
////                record.tags = NSSet(tag)
//                
                record.save()
//                
//                tag.addToRecord(record)
//                
//            }
            
            
            
            
            
            

//            var tag = Tag(context: Tag.viewContext)
//            tag.id = uuid



//            let tag: Tag? = Tag.byId(id: uuid)

//            if let tag = tag {
//                //place record creation in here
//
//            }



//            let decoder = JSONDecoder()
//
//            if let loadedTag = try? decoder.decode(SettingsTag.self, from: uuid_data) { //not working 5-24-22
//                print("before")
//                print(loadedTag)
//                print("after")
//
////                var uuid = UUID(uuidString: loadedTag.id)
//
////                tag.id = UUID()
////                tag.name = loadedTagString.name
//
//                /*
//                 get a tag by uuid
//                 */
//
//                let tag: Tag? = Tag.byId(id: tag.objectID)
//                if let tag = tag {
////place record creation in here
//
//                }
//            }

        }
        
        
        
//        if let savedItems = UserDefaults.standard.data(forKey: "tag_uuid") {
//            if let decodedItems = try? JSONDecoder().decode(SettingsTag.self, from: savedItems) {
//
//                print("before")
//                print(decodedItems)
//                print("after")
//            }
//        }
        
        // this may create multiple tags with the same name, probably not what you want
        
        //addActorToMovie(movieId: NSManagedObjectID)
        //let tag2: Tag? = Tag.byId(id: tag.id)
        
        /* test
         
         func deleteTag(tag: TagViewModel) {
         let tag: Tag? = Tag.byId(id: tag.id)
         if let tag = tag {
         tag.delete()
         }
         }
         
         end test*/
        

    }
    
    func getItem(with id: UUID?) -> Tag? {
        guard let id = id else { return nil }
        let request = Tag.fetchRequest() as NSFetchRequest<Tag>
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let items = try? viewContext.fetch(request) else { return nil }
        return items.first
    }
    
//    func addRecordToCategoryAndTag(categoryId: NSManagedObjectID, tagId: NSManagedObjectID) {
//        
//        let category: Category? = Category.byId(id: categoryId)
//        let tag: Tag? = Tag.byId(id: tagId)
//        
//        if let category = category {
//            if let tag = tag {
//                
//                let record = Record(context: Record.viewContext)
//                record.name = name
//                record.addToCategory(category)
//                
//                record.question = self.question
//                record.answer = self.answer
//                record.id = self.id
//                record.addToCategory(category)
//                record.addToTags(tag)
//                
//                record.save()
//            }
//        }
//    }
//    
//    func addRecordToCategoryAndTag(categoryId: NSManagedObjectID, tagId: NSManagedObjectID) {
//        
//        let category: Category? = Category.byId(id: categoryId)
//        let tag: Tag? = Tag.byId(id: tagId)
//        
//        if let category = category {
//            if let tag = tag {
//                
//                let record = Record(context: Record.viewContext)
//                record.question = self.question
//                record.answer = self.answer
//                record.id = self.id
//                record.category = category
//                record.addToTags(tag)
//                
//                record.save()
//            }
//        }
//    }

}
