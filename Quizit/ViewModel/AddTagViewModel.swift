//
//  AddTagViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/30/21.
//

import Foundation
import CoreData

class AddTagViewModel: ObservableObject {
    
    var name: String = ""
    let id: UUID = UUID()
    
    func save() {
        
        let tag = Tag(context: Tag.viewContext)
        tag.name = self.name
        tag.id = self.id
        
        tag.save()
    }
}
