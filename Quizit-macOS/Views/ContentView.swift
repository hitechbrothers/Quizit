//
//  ContentView.swift
//  Quizit-macOS
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext: NSManagedObjectContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var catagories: FetchedResults<Category>
  
    @State private var isAddPresented: Bool = false

    var body: some View {
        NavigationView() {
          List {
            ForEach(self.catagories) { category in
            CategoryCell(category: category)
                .contextMenu {
                    Button(action: {
                        // delete item in items array
                    }){Text("Delete")}
                }
            }
            .onDelete(perform: deleteCategory) //not working
          }
          .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItem() {
                HStack {
                    Button(action: {self.isAddPresented = true}) {Text("Add")}
                    .popover(isPresented: $isAddPresented) {
                        AddCategoryView()
//                        AddCategoryView(context: self.context)
                    }
                    
                    Spacer()
                }
            }
        }
          
        }
    }
    
//    private func deleteCategory(with indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let category = catagories[index]
//            context.delete(category)
//        }
//        try? context.save()
//    }
    
    private func deleteCategory(offsets: IndexSet) {
        withAnimation {
            offsets.map { catagories[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
}

struct CategoryCell: View {
    let category: Category
    
    var body: some View {
        NavigationLink(destination: CategoryDetailView(category: category)) {
            Text(category.name!)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
