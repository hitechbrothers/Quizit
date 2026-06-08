//
//  TagQuestionsViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 12/6/21.
//

import Foundation
import CoreData

class TagQuestionsViewModel: ObservableObject {
    
    @Published var records = [RecordViewModel]()

    func getallRecords() { //change later to get all records by tag
        
        let records: [Record] = Record.all(orderBy: "question")
        DispatchQueue.main.async {
            self.records = records.map(RecordViewModel.init)
        }
    }
    
    func deleteRecord(record: RecordViewModel) {
        let record: Record? = Record.byId(id: record.id)
        if let record = record {
            record.delete()
        }
    }
}
