//
//  CategoryListViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/10/21.
//

import Foundation

@Observable
class CategoriesViewModel {
    
    var categories: [CategoryDO] = []
    
    func getallCategories() {
        
        let categories: [Category] = Category.all(orderBy: "name")
        DispatchQueue.main.async {
            self.categories = categories.map(CategoryDO.init)
        }
    }
    
    func deleteCategory(category: CategoryDO) {
        let category: Category? = Category.byId(id: category.id)
        if let category = category {
            category.delete()
        }
    }
}
