//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryDetailView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

    let category: Category
    
    @State var isAddQuestionPresented: Bool = false
    @State var isAnswerPresented: Bool = false
        
    var body: some View {
        NavigationView {
            List {

                
                Section(header: Text("Tag goes here").foregroundColor(.blue)) {
                    /* Remove after testing */
                    Button(action: {
                        self.isAddQuestionPresented = true
                    }) {
                         HStack {
                             Spacer()
                             Image(systemName: "plus.circle")
                             Text("Add Question")
                             Spacer()
                         }
            //             .foregroundColor(Color(.red))
                    }
                    /* Remove after testing */

                        HStack {
                            Spacer()
                            Text("Question")
                                .bold()
                            Spacer()
                        }
                        .padding(5)
                    
                        Text("Kd kdfsk kids kldsf   ndsklfdsk nds klfd dfsklkfds lfds ls sdks")
                }
            }
            .sheet(isPresented: $isAddQuestionPresented) {
//                AddQuestionView(context: self.context)
            }
//            .sheet(isPresented: $isAnswerPresented) {
////              AnswerView(context: self.context)
//                AnswerView()
//            }
            .navigationBarTitle(Text(category.name!))
            
//            Button(action: {self.isAnswerPresented = true}) {
//                     HStack {
//                         Spacer()
//                         Text("Answer")
//                         Spacer()
//                     }
//            }
//            Spacer()
        }
    }
}

//code below for preview in xcode only
//struct CategoryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//      CategoryDetailView(category: category)
////      NavigationView { CategoryDetailView(category: self.category) }
//    }
//}
