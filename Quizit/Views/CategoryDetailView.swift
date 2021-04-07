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
    
    @State var isAnswerPresented: Bool = false
        
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Tag goes here").foregroundColor(.blue)) {

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
