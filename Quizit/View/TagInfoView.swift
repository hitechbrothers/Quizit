//
//  TagInfoView.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/5/21.
//

import SwiftUI
import CoreData

struct TagInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var tagInfoVM = TagInfoViewModel()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(tagInfoVM.tags) { tag in
                    TagCell(tag: tag)
                }
                .onDelete(perform: deleteTag)
            }
            .sheet(isPresented: $isAddFormPresented, onDismiss: {
                tagInfoVM.getallTags()
            }, content: {
                AddTagView()
            })
            .navigationBarTitle("Info", displayMode: .inline)
            .navigationBarItems(leading: Button(action: self.onCancelTapped) {Text("Cancel")}, trailing: Button(action: addTapped) {Text("Add")})
            .onAppear(perform: {
                tagInfoVM.getallTags()
            })
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteTag(with indexSet: IndexSet) {
        
        indexSet.forEach { index in
            let tag = tagInfoVM.tags[index]
            
            //delete the tag
            tagInfoVM.deleteTag(tag: tag)
            //get all tags to refresh list
            tagInfoVM.getallTags()
        }
    }
}

struct TagCell: View {
    
    let tag: TagViewModel
    
    var body: some View {
        Text(tag.name)
    }
}

struct TagInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TagInfoView()
    }
}
