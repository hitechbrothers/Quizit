//
//  TagInfoViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/24/21.
//

import Foundation

@Observable
class TagInfoViewModel /* : ObservableObject */ {
    
//    @Published var tags = [TagViewModel]()
    var tags: [TagDO] = []
    
    func getallTags() {
        
        let tags: [Tag] = Tag.all(orderBy: "name")
        DispatchQueue.main.async {
            self.tags = tags.map(TagDO.init)
        }
    }
    
    func deleteTag(tag: TagDO) {
        let tag: Tag? = Tag.byId(id: tag.id)
        if let tag = tag {
            tag.delete()
        }
    }
}
