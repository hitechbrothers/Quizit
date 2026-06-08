//
//  AddQuestionViewModel.swift
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

class AddQuestionViewModel: ObservableObject {
    
    //    let category: CategoryViewModel
    
    @Published var answer: String = ""
    @Published var question: String = ""
    let id: UUID = UUID()
    
    //    init() {
    //        self.category =
    //    }
    
    func save(category: Category) {
        
        
        //Get the tag in UserDefaults
        let defaults = UserDefaults.standard
        let tag = Tag(context: Tag.viewContext)
        
        if let savedTag = defaults.object(forKey: "tag_uuid") as? Data {
            let decoder = JSONDecoder()
            if let loadedTag = try? decoder.decode(SettingsTag.self, from: savedTag) {
                print(loadedTag.id)
//                print(loadedTag.name)
                tag.id = UUID()
                tag.name = loadedTag.id
//                tag.name = loadedTag.name
            }
        }
        
        // this may create multiple tags with the same name, probably not what you want
        
        //addActorToMovie(movieId: NSManagedObjectID)
        //let tag2: Tag? = Tag.byId(id: tag.id)
        
        let record = Record(context: Record.viewContext)
        record.question = self.question
        record.answer = self.answer
        record.id = self.id
        record.category = category
//        record.tags = tag //needs NSSet
        record.addToTags(tag)  //it dosen't like this probably needs tag byId use byId see MovieApp
        
        record.save()
    }
}
