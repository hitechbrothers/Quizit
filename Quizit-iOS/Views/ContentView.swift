//
//  ContentView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var categoriesOO = CategoriesViewModel()
    @State private var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categoriesOO.categories, id: \.self) { categoryDO in
                    NavigationLink {
                        CategoryDetailView(categoryDO: categoryDO)
                    } label: {
                        CategoryCell(categoryDO: categoryDO)
                    }
                }
                .onDelete(perform: deleteCategory)
            }
            .navigationTitle("Categories")
            .navigationBarItems(trailing: Button("Add") {
                isAddFormPresented = true
            })
            .sheet(isPresented: $isAddFormPresented, onDismiss: {
                categoriesOO.getallCategories()
            },  content: {
                AddCategoryView()
            })
            .onAppear(perform: {
                categoriesOO.getallCategories()
            })
        }
    }
    
    private func deleteCategory(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let category = categoriesOO.categories[index]
            
            //delete the category
            categoriesOO.deleteCategory(category: category)
            
            //get all categories to refresh list
            categoriesOO.getallCategories()
        }
    }
}

struct CategoryCell: View {
    let categoryDO: CategoryDO
    
    var body: some View {
        Text(categoryDO.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
