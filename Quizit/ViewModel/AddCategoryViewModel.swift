//
//  AddCategoryViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/22/21.
//

import Foundation
import CoreData

class AddCategoryViewModel: ObservableObject {
    
    var name: String = ""
    let id: UUID = UUID()
    
    func save() {
        
        let category = Category(context: Category.viewContext)
        category.name = self.name
        category.id = self.id
        
        category.save()
    }
}
