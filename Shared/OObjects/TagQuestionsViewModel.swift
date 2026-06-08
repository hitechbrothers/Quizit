//
//  TagQuestionsViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 12/6/21.
//

import Foundation
import CoreData

@Observable
class TagQuestionsViewModel {
    
    var records: [RecordDO] = []

    func getallRecords() { //change later to get all records by tag
        
        let records: [Record] = Record.all(orderBy: "question")
        DispatchQueue.main.async {
            self.records = records.map(RecordDO.init)
        }
    }
    
    func deleteRecord(record: RecordDO) {
        let record: Record? = Record.byId(id: record.id)
        if let record = record {
            record.delete()
        }
    }
}
