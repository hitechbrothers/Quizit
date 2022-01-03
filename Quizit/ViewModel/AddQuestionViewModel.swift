//
//  AddQuestionViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 12/9/21.
//

import Foundation
import CoreData

class AddQuestionViewModel: ObservableObject {
    
//    let category: CategoryViewModel
    var answer: String = ""
    var question: String = ""
    let id: UUID = UUID()
    
//    init() {
//        self.category = 
//    }
    
    func save() {
        
        let record = Record(context: Record.viewContext)
        record.question = self.question
        record.answer = self.answer
        record.id = self.id
        
        record.save()
    }
}
