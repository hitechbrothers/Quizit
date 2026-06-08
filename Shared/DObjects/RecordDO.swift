//
//  RecordDO.swift
//  Quizit-iOS
//
//  Created by Diego Acevedo on 6/6/26.
//

import Foundation
import CoreData

struct RecordDO: Identifiable {
    
    let record: Record

    var answer: String {
        return record.wrappedAnswer
    }
    
    var id: NSManagedObjectID {
        return record.objectID
    }
    
    var question: String {
        return record.wrappedQuestion
    }
    
    var category: Category {
        return record.wrappedCategory
    }
    
    var tags: [Tag] {
        return record.tagArray
    }
}
