//
//  TagQuestionsView.swift
//  Quizit
//
//  Created by Diego Acevedo on 9/28/21.
//

import SwiftUI
import CoreData

struct TagQuestionsView: View {
    
    let categoryVM: CategoryViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var tagQuestionsVM = TagQuestionsViewModel()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {

        NavigationView {
            
            List {
                ForEach(tagQuestionsVM.records) { record in
                    RecordCell(record: record)
                }
                .onDelete(perform: deleteRecord)
            }
            .sheet(isPresented: $isAddFormPresented, onDismiss: {
                tagQuestionsVM.getallRecords()
            },  content: {
                AddQuestionView(categoryVM: categoryVM)
            })
            .navigationBarItems(leading: Button(action: self.onCancelTapped) {Text("Cancel")})
            .navigationBarTitle("Tag Selected", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: addTapped) {Text("Add")})
            .onAppear(perform: {
                tagQuestionsVM.getallRecords()
            })
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    private func deleteRecord(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let record = tagQuestionsVM.records[index]
            
            //delete the record
            tagQuestionsVM.deleteRecord(record: record)
            //get all records to refresh list
            tagQuestionsVM.getallRecords()
        }
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct RecordCell: View {
    
    let record: RecordViewModel
    
    var body: some View {
//        NavigationLink(destination: CategoryDetailView(category: category)) {
//            Text(record.category.name!)
//        }
        NavigationLink(destination: AnswerView()) { //fix later
            Text(record.question)
        }
    }
}

struct TagQuestionsView_Previews: PreviewProvider {
    
    let category: CategoryViewModel
    
    static var previews: some View {
//        TagQuestionsView(category: category)
        TagQuestionsView(categoryVM: CategoryViewModel(category: Category(context: Category.viewContext)))
    }
}
