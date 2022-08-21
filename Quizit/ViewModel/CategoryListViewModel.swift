//
//  CategoryListViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/10/21.
//

import Foundation
import CoreData
import SwiftUI

struct CategoryViewModel: Identifiable {

    var category: Category = Category()

    var name: String {
        return category.name ?? ""
    }

    var id: NSManagedObjectID {
        return category.objectID
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
