//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryDetailView: View {
    
    let categoryDO: CategoryDO
    @State private var categoryDetailOO: CategoryDetailViewModel
    @State private var isTagQuestionPresented: Bool = false
    @State private var isAnswerPresented: Bool = false
    @State private var isTagInfoPresented: Bool = false
    @State private var settings = UserSettings()
    
    init(categoryDO: CategoryDO) {
        self.categoryDO = categoryDO //so the view can use it later
        _categoryDetailOO = State( //initialize the wrapper directly
            initialValue: CategoryDetailViewModel(
                category: categoryDO.category
            )
        )
    }
    
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
                                if let tag = categoryDetailOO.record_Tag.tag {
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

                    if let record = categoryDetailOO.record_Tag.record {
                            Text(record.wrappedQuestion)
                    }
                    else {
                        Text("<no_question>")
                    }
                }
                .sheet(isPresented: $isTagQuestionPresented) {
                    TagQuestionsView(categoryDO: categoryDO)
                }
                .sheet(isPresented: $isTagInfoPresented) {
                    TagInfoView()
                }
                .sheet(isPresented: $isAnswerPresented) {
//                    if let record = result.record {
//                        AnswerView(recordAnswer: record.wrappedAnswer)
//                    AnswerView(result: $result)
                    AnswerView(categoryDetailVM: categoryDetailOO, category: categoryDO.category)
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
            .navigationBarTitle(Text(categoryDO.name))
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
            categoryDetailOO.getRandomRecordPlusRandomTag(category: categoryDO.category)
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

