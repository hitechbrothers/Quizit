//
//  AddTagView.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/7/21.
//

import SwiftUI
import CoreData

struct AddTagView: View {
    
    var context: NSManagedObjectContext
    @State private var newTag: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: self.onCancelTapped) {Text("Cancel")}
                    .padding(.leading)
                Spacer()
                Text("Add Tag")
                Spacer()
                Button(action: self.onSaveTapped) {Text("Save")}
                    .padding(.trailing)
            }
            TextField("New Tag", text: $newTag)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
        }
        .padding(.top, 25.0)
    }
    
    private func onSaveTapped() {
        
        if (self.newTag.isEmpty)
            {return}
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let newTag = Tag(context: self.context)
        newTag.name = self.newTag
        newTag.id = UUID()
        
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

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = PersistenceController()
        AddTagView(context: stack.container.viewContext)
    }
}
