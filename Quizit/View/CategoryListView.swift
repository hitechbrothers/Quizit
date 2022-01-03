//
//  ContentView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI

struct CategoryListView: View {
    
    @StateObject private var categoryListVM = CategoryListViewModel()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        
      NavigationView {
        
        List {
          ForEach(categoryListVM.categories) { category in
              CategoryCell(category: category)
          }
          .onDelete(perform: deleteCategory)
        }
        .sheet(isPresented: $isAddFormPresented, onDismiss: {
            categoryListVM.getallCategories()
        },  content: {
            AddCategoryView()
        })
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: addTapped) {Text("Add")})
        .onAppear(perform: {
            categoryListVM.getallCategories()
        })
      }
    }
  
    func addTapped() {
        isAddFormPresented = true
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
    
    let category: CategoryViewModel
    
    var body: some View {
        NavigationLink(destination: CategoryDetailView(category: category)) {
            Text(category.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      CategoryListView()
    }
}
