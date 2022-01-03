//
//  AddTagView.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/7/21.
//

import SwiftUI
import CoreData

struct AddTagView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addTagVM = AddTagViewModel()
    
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
            TextField("New Tag", text: $addTagVM.name)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
        }
        .padding(.top, 25.0)
    }
    
    private func onSaveTapped() {
        
        if (self.addTagVM.name.isEmpty) {
            return
        }
        
        addTagVM.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagView()
    }
}
