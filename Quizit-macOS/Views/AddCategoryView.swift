//
//  AddCategoryView.swift
//  Quizit-macOS
//
//  Created by Diego Acevedo on 3/5/21.
//

import SwiftUI
import CoreData

struct AddCategoryView: View {
    
    var categoryToEdit: Category?
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var category: String = ""
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var body: some View {
        VStack {
            Form {
                TextField("Category", text: $category)
                    .disableAutocorrection(true)
                Button(action: self.onSaveTapped) {
                    Text("Save")
                }
            }
            .padding()
            
        }
        .frame(minWidth: 300)
    }
    
    private func onSaveTapped() {
        let category: Category
        if let categoryToEdit = self.categoryToEdit {
            category = categoryToEdit
        } else {
            category = Category(context: self.context)
            category.id = UUID()
        }
        
        category.name = self.category
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
}



struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
//        let stack = PersistenceController()
//        persistenceController.container.viewContext
//        return AddCategoryView(context: stack.container.viewContext)
    }
}
