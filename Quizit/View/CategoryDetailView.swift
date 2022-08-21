//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryDetailView: View {
        
    let categoryVM: CategoryViewModel
    @State private var categoryDetailVM = CategoryDetailViewModel()
    @State var isTagQuestionPresented: Bool = false
    @State var isAnswerPresented: Bool = false
    @State var isTagInfoPresented: Bool = false
//    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        NavigationView {
            VStack {
                
                /* test area for settings*/

//                Toggle(isOn: $settings.isRandom) {
//                    Text("Random")
//                }
//                .padding()

                /* end test area for settings */
                

                List {
                    let record = categoryDetailVM.getRecord(categoryVM: categoryVM)

                    HStack {
                        Button(action: {
                            self.isTagQuestionPresented = true
                        }) {
                            HStack {
//                                Text(tag!.name ?? "<no_tag>")
//                                Text("Some tag")
//                                Text(record.tags!.name ?? "<no_tag>")
//                                Text(record!.tags!.name ?? "<no_tag>")
                                if let record = record {
                                    Text(record.tags!.name!)
                                        .foregroundColor(.blue)
                                }
                                else {
                                    Text("<no_tag>")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.lightGray))
                    
                    HStack {
                        Spacer()
                        Text("Question")
                            .bold()
                        Spacer()
                    }
                    .padding(5)

//                    Text(record.question ?? "<no_question>")
//                    Text(record.category?.name ?? "<no_category>")
                    
                    if let record = record {
                        Text(record.question!)
                    }
                    else {
                        Text("<no_question>")
                    }
                    
                    if let record = record {
                        Text(record.category!.name!)
                    }
                    else {
                        Text("<no_category>")
                    }
                }
                .sheet(isPresented: $isTagQuestionPresented) {
                    TagQuestionsView(categoryVM: categoryVM)
                }
                .sheet(isPresented: $isTagInfoPresented) {
                    TagInfoView()
                }
                .sheet(isPresented: $isAnswerPresented) {
                    AnswerView()
                }
                
                Button(action: {
                    self.isAnswerPresented = true
                }) {Text("Answer")}
            }
            .navigationBarTitle(Text(categoryVM.name))
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

struct CategoryDetail_Previews: PreviewProvider {
    
    let category: CategoryViewModel
    
    static var previews: some View {
        CategoryDetailView(categoryVM: CategoryViewModel(category: Category(context: Category.viewContext)))
    }
}
