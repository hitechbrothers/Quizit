//
//  ContentView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
  
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default)
    private var catagories: FetchedResults<Category>
    
//    @FetchRequest(entity: Category.entity(), sortDescriptors: [])
//    var catagories: FetchedResults<Category>

    @State var isAddFormPresented: Bool = false
    @StateObject var record = ObservedRecord()
    
    var body: some View {
        
      NavigationView {
        
        List {
          ForEach(self.catagories) { category in
              CategoryCell(category: category)
          }
          .onDelete(perform: deleteCategory)
        }
        .sheet(isPresented: $isAddFormPresented) {
          AddCategoryView(context: self.context)
        }
  //      .navigationBarTitle(Text("Categories"))
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: addTapped) {Text("Add")})
      }
      .environmentObject(record)
    }
  
    func addTapped() {
        isAddFormPresented = true
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
//            let uuidString: String? = category.id?.uuidString
//            Text(uuidString!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
