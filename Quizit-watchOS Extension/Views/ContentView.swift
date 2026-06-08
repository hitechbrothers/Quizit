//
//  ContentView.swift
//  Quizit-watchOS Extension
//
//  Created by Diego Acevedo on 3/9/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

    
    @State private var CategoryToEdit: Category?
    @State private var isAddPresented: Bool = false
    
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var catagories: FetchedResults<Category>
    
    var body: some View {
        List {
                
            Button(action: {
                 self.isAddPresented = true
            }) {
                 HStack {
                     Spacer()
                     Image(systemName: "plus.circle")
                     Text("Add Category")
                     Spacer()
                 }
                 .foregroundColor(Color(.red))
            }
            
            ForEach(self.catagories) { category in
                CategoryCell(category: category)
            }
            .onDelete(perform: deleteCategory)
        }
        .sheet(isPresented: $isAddPresented) {
            AddCategoryView(context: self.context)
        }
    }
    
    private func deleteCategory(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let category = catagories[index]
            context.delete(category)
        }
        try? context.save()
    }
}

struct CategoryCell: View {
    let category: Category
    
    var body: some View {
        NavigationLink(destination: CategoryDetailView(category: category)) {
            Text(category.name!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
