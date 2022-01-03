//
//  CategoryDetailViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/22/21.
//

import Foundation
import CoreData

struct RecordViewModel: Identifiable {
    
    let record: Record
    
    var question: String {
        return record.question ?? ""
    }
    
    var category: Category {
        return record.category ?? Category()
    }
    
    var id: NSManagedObjectID {
        return record.objectID
    }
}

class CategoryDetailViewModel: ObservableObject {
    
    @Published var records = [RecordViewModel]()
    
    func getRandomRecord() -> Record {
        
        let records: [Record] = Record.all(orderBy: "question")
        DispatchQueue.main.async {
            self.records = records.map(RecordViewModel.init)
        }
        
        let record = records.randomElement()
        return record ?? Record()
//        record?.question ?? "<no_question>"

    }
}
