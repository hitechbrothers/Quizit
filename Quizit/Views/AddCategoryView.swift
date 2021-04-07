//
//  AddCategoryView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/9/21.
//

import SwiftUI
import CoreData

struct AddCategoryView: View {
  
  var categoryToEdit: Category?
  var context: NSManagedObjectContext
  @State private var newCategory: String = ""
//  @State var name: String = ""
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
      VStack {
        HStack {
          Button(action: self.onCancelTapped) {Text("Cancel")}
          .padding(.leading)
          Spacer()
          Text("Add Category")
          Spacer()
          Button(action: self.onSaveTapped) {Text("Save")}
          .padding(.trailing)
        }
        TextField("New Category", text: $newCategory)
          .disableAutocorrection(true)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        Spacer()
      }
      .padding(.top, 25.0)
    }

  private func onSaveTapped() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      
//      let category: Category?
//      if let categoryToEdit = self.categoryToEdit {
//        category = categoryToEdit
//      } else {
//        category = Category(context: self.context)
////        category.id = UUID()
//      }
//    
//      category.name = self.newCategory
    
    let newCat = Category(context: self.context)
    newCat.name = self.newCategory
    newCat.id = UUID()
      
      do {
          try context.save()
      } catch let error as NSError {
          print(error.localizedDescription)
      }
      
      self.presentationMode.wrappedValue.dismiss()
  }
  
  private func onCancelTapped() {
      self.presentationMode.wrappedValue.dismiss()
  }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
      let stack = PersistenceController()
      AddCategoryView(context: stack.container.viewContext)
    }
}
