//
//  ContentView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var categoryListVM = CategoryListViewModel()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categoryListVM.categories, id: \.self) { categoryVM in
                    NavigationLink {
                        CategoryDetailView(category: categoryVM.category)
                    } label: {
                        CategoryCell(categoryVM: categoryVM)
                    }
                }
                .onDelete(perform: deleteCategory)
            }
            .navigationTitle("Categories")
            .navigationBarItems(trailing: Button("Add") {
                isAddFormPresented = true
            })
            .sheet(isPresented: $isAddFormPresented, onDismiss: {
                categoryListVM.getallCategories()
            },  content: {
                AddCategoryView()
            })
            .onAppear(perform: {
                categoryListVM.getallCategories()
            })
        }
    }
    
    private func deleteCategory(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let category = categoryListVM.categories[index]
            
            //delete the category
            categoryListVM.deleteCategory(category: category)
            
            //get all categories to refresh list
            categoryListVM.getallCategories()
        }
    }
}

struct CategoryCell: View {
    let categoryVM: CategoryViewModel
    
    var body: some View {
        Text(categoryVM.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
