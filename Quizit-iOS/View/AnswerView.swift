//
//  AnswerView.swift
//  Quizit
//
//  Created by Diego Acevedo on 3/12/21.
//

import SwiftUI
import CoreData

struct AnswerView: View {
//    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
//    let record: Record
    
//    let recordVM: RecordViewModel
    
//    let recordAnswer: String
    
    @Bindable var categoryDetailVM: CategoryDetailViewModel
    let category: Category
    @State var isAnswerPresented: Bool = true
    @Environment(\.presentationMode) var presentationMode //test

    var body: some View {
//        Text(recordAnswer)
        
        NavigationView {
            VStack {
                
                if let record = categoryDetailVM.record_Tag.record {
                    Text(record.wrappedAnswer)
                }

                Button(action: {
                    //                self.isAnswerPresented = true
                    categoryDetailVM.getRandomRecordPlusRandomTag(category: category)
                    self.presentationMode.wrappedValue.dismiss()
                }) {Text("New")}
            }
        }
        
//        if let record = record {
//            Text(record.answer!)
//        }
//        else {
//            Text("<no_tag>")
//                .foregroundColor(.blue)
//        }
    }
}

//struct AnswerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerView(recordAnswer)
//    }
//}
