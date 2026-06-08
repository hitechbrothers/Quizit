//
//  CategoryListViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/10/21.
//

import Foundation
import CoreData

struct CategoryViewModel: Identifiable, Hashable {
    
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

class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [CategoryViewModel]()
    
    func getallCategories() {
        
        let categories: [Category] = Category.all(orderBy: "name")
        DispatchQueue.main.async {
            self.categories = categories.map(CategoryViewModel.init)
        }
    }
    
    func deleteCategory(category: CategoryViewModel) {
        let category: Category? = Category.byId(id: category.id)
        if let category = category {
            category.delete()
        }
    }
}
