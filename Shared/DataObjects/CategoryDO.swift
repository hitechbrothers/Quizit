//
//  CategoryViewModel.swift
//  Quizit-iOS
//
//  Created by Diego Acevedo on 4/11/24.
//

import Foundation
import CoreData

struct CategoryDO: Identifiable, Hashable {
    
    let category: Category
    
    var id: NSManagedObjectID {
        return category.objectID
    }
    
    var name: String {
        return category.wrappedName
    }
    
    var records: [Record] {
        return category.recordArray
    }
}
