//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData
import Combine

struct CategoryDetailView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    let category: Category
	
    @State var isAddQuestionPresented: Bool = false
    @State var isAnswerPresented: Bool = false
    @State var isTagInfoPresented: Bool = false
    
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        NavigationView {
            VStack {
                
                /* test area for settings*/
//                VStack {
//                    Form {
//                        Section(header: Text("PROFILE")) {
                            Toggle(isOn: $settings.isRandom) {
                                Text("Random")
                            }
                            .padding()
//                        }
//                    }
//                }
                /* end test area for settings */
                
                List {
                    
                    HStack {
                        Text("Tag goes here")
                            .padding()
                            .foregroundColor(.blue)
                            .background(Color.gray)
                    }
                    
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
                .sheet(isPresented: $isAddQuestionPresented) {
                    AddQuestionView(context: self.context, category: category)
                }
                .sheet(isPresented: $isTagInfoPresented) {
                    TagInfoView()
                }
                //            .sheet(isPresented: $isAnswerPresented) {
                ////              AnswerView(context: self.context)
                //                AnswerView()
                //            }
            }
            .navigationBarTitle(Text(category.name!))
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    self.isTagInfoPresented = true
                }) {
                    Image(systemName: "info.circle")
                }
        )
    }
}

//code below for preview in xcode only
//struct CategoryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//      CategoryDetailView(category: category)
////      NavigationView { CategoryDetailView(category: self.category) }
//    }
//}
