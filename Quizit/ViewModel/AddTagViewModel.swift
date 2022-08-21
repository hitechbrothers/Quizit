//
//  AddTagViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/30/21.
//

import Foundation
import CoreData

class AddTagViewModel: ObservableObject {
    
    @Published var name: String = ""
    let id = UUID()

    func save() {
        
        let tag = Tag(context: Tag.viewContext)
        tag.name = self.name
        tag.id = self.id
        
        tag.save()
        
        //Save the tag to UserDefaults
//        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard
        
//        if let encoded = try? encoder.encode(tag.name) {
//            defaults.set(encoded, forKey: "savedTag")
//        }
        
//        if let encoded = try? encoder.encode(id.uuidString) {
//            defaults.set(encoded, forKey: "tag_uuid")
//        }
        
//        if let encoded = try? encoder.encode(id) {
//            defaults.set(encoded, forKey: "tag_uuid")
//        }
        
        defaults.set(id.uuidString, forKey: "tag_uuid")
    }
}
