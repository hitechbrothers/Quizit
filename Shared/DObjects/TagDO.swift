//
//  TagDO.swift
//  Quizit-iOS
//
//  Created by Diego Acevedo on 9/8/25.
//

import Foundation
import CoreData

struct TagDO: Identifiable {
    
    let tag: Tag
    
    var id: NSManagedObjectID {
        return tag.objectID
    }
    
    var name: String {
        return tag.wrappedName
    }
    
    var records: [Record] {
        return tag.recordArray
    }
}
