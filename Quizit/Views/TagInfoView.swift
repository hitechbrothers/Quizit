//
//  TagInfoView.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/5/21.
//

import SwiftUI
import CoreData

struct TagInfoView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: true)], animation: .default)
    private var tags: FetchedResults<Tag>
    
    @State var isAddFormPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var tag = ObservedRecord()
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(self.tags) { tag in
                    TagCell(tag: tag)
                }
                .onDelete(perform: deleteTag)
            }
            .sheet(isPresented: $isAddFormPresented) {
                AddTagView(context: self.context)
            }
            //      .navigationBarTitle(Text("Categories"))
            .navigationBarTitle("Info", displayMode: .inline)
            .navigationBarItems(leading: Button(action: self.onCancelTapped) {Text("Cancel")}, trailing: Button(action: addTapped) {Text("Add")})
        }
        .environmentObject(tag)
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteTag(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let tag = tags[index]
            context.delete(tag)
        }
        try? context.save()
    }
}

struct TagCell: View {
    let tag: Tag
    
    var body: some View {
       //NavigationLink(/* destination: CategoryDetailView(category: category) */) {
            Text(tag.name!)
            //            let uuidString: String? = category.id?.uuidString
            //            Text(uuidString!)
        //}
    }
}

struct TagInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TagInfoView()
    }
}
