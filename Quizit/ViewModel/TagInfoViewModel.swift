//
//  TagInfoViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/24/21.
//

import Foundation
import CoreData

struct TagViewModel: Identifiable {
    
    let tag: Tag
    
    var name: String {
        return tag.name ?? ""
    }
    
    var id: NSManagedObjectID {
        return tag.objectID
    }
}

class TagInfoViewModel: ObservableObject {
    
    @Published var tags = [TagViewModel]()
    
    func getallTags() {
        
        let tags: [Tag] = Tag.all(orderBy: "name")
        DispatchQueue.main.async {
            self.tags = tags.map(TagViewModel.init)
        }
    }
    
    func deleteTag(tag: TagViewModel) {
        let tag: Tag? = Tag.byId(id: tag.id)
        if let tag = tag {
            tag.delete()
        }
    }
}
