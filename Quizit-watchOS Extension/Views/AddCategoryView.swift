//
//  AddCategoryView.swift
//  Quizit-watchOS Extension
//
//  Created by Diego Acevedo on 3/11/21.
//

import SwiftUI
import CoreData

struct AddCategoryView: View {
   
    var CategoryToEdit: Category?
    var context: NSManagedObjectContext
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @State var name: String = ""

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
            }
            
            Section {
               Button(action: self.onSaveTapped) {
                   HStack {
                       Spacer()
                       Text("Save")
                           .foregroundColor(Color.white)
                       Spacer()
                   }
               }
               .listRowPlatterColor(Color.blue)
               
               if self.CategoryToEdit != nil {
                   Button(action: self.onDeleteTapped) {
                       HStack {
                           Spacer()
                           Text("Delete")
                               .foregroundColor(Color.white)
                           Spacer()
                       }
                   }
                   .listRowPlatterColor(Color.red)
               }
           }
        }
    }
    
    private func onSaveTapped() {
        let category: Category
        if let CategoryToEdit = self.CategoryToEdit {
            category = CategoryToEdit
        } else {
            category = Category(context: self.context)
            category.id = UUID()
        }
        
        category.name = self.name
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onDeleteTapped() {
         guard let CategoryToEdit = self.CategoryToEdit else { return }
         self.context.delete(CategoryToEdit)
         try? context.save()
         self.presentationMode.wrappedValue.dismiss()
     }
}
