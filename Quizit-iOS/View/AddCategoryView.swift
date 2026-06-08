//
//  AddCategoryView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/9/21.
//

import SwiftUI
import CoreData

struct AddCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addCategoryVM = AddCategoryViewModel()

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
            TextField("New Category", text: $addCategoryVM.name)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
        }
        .padding(.top, 25.0)
    }

    private func onSaveTapped() {
        
        if (self.addCategoryVM.name.isEmpty) {
            return
        }
        
        addCategoryVM.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
  
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
      AddCategoryView()
    }
}
