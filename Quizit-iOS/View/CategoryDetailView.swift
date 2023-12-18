//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryDetailView: View {
    
    @State private var categoryDetailVM = CategoryDetailViewModel()
    let category: Category
    @State var isTagQuestionPresented: Bool = false
    @State var isAnswerPresented: Bool = false
    @State var isTagInfoPresented: Bool = false
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        
        NavigationView {
            VStack {
//                @State var result = categoryDetailVM.getRandomRecordPlusRandomTag(category: category)

                List {
                    HStack {
                        HStack {
                            Button(action: {
                                self.isTagInfoPresented = true
                            }) {
//                                if let tag = result.tag {
                                if let tag = categoryDetailVM.record_Tag.tag {
                                    Text(tag.name!)
                                        .foregroundColor(.blue)
                                } else {
                                    Text("<no_tag>")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        HStack {
                            Image(systemName: "info.circle")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.blue)
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

                    if let record = categoryDetailVM.record_Tag.record {
                            Text(record.wrappedQuestion)
                    }
                    else {
                        Text("<no_question>")
                    }
                }
                .sheet(isPresented: $isTagQuestionPresented) {
                    TagQuestionsView(category: category)
                }
                .sheet(isPresented: $isTagInfoPresented) {
                    TagInfoView()
                }
                .sheet(isPresented: $isAnswerPresented) {
//                    if let record = result.record {
//                        AnswerView(recordAnswer: record.wrappedAnswer)
//                    AnswerView(result: $result)
                        AnswerView(categoryDetailVM: categoryDetailVM, category: category)
//                    }
//                    else {
//                        AnswerView(recordAnswer: "<no_answer>")
//                    }
                }
                
                Button(action: {
//                    categoryDetailVM.getRandomRecordPlusRandomTag(category: category)
                    self.isAnswerPresented = true
                }) {Text("Answer")}
            }
            .navigationBarTitle(Text(category.wrappedName))
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    self.isTagQuestionPresented = true
                }) {
                    HStack {
                            Text("Related")
                                .foregroundColor(.blue)
                    }
                }
        )
        .onAppear {
            categoryDetailVM.getRandomRecordPlusRandomTag(category: category)
        }
    }
}

//struct CategoryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        
//        CategoryDetailView(category: record.category)
//    }
//}
