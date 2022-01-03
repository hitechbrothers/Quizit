//
//  CategoryDetailView.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryDetailView: View {
        
    let category: CategoryViewModel
    @State private var categoryDetailVM = CategoryDetailViewModel()
    @State var isTagQuestionPresented: Bool = false
    @State var isAnswerPresented: Bool = false
    @State var isTagInfoPresented: Bool = false
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        NavigationView {
            VStack {
                
                /* test area for settings*/

                Toggle(isOn: $settings.isRandom) {
                    Text("Random")
                }
                .padding()

                /* end test area for settings */
                

                List {
                    HStack {
                        Button(action: {
                            self.isTagQuestionPresented = true
                        }) {
                            HStack {
//                                Text(tag!.name ?? "<no_tag>")
                                Text("Some tag")
                                    .foregroundColor(.blue)
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

                    let record = categoryDetailVM.getRandomRecord()

                    Text(record.question ?? "<no_question>")
                    Text(record.category?.name ?? "<no_category>")
                }
                .sheet(isPresented: $isTagQuestionPresented) {
                    TagQuestionsView(category: category)
                }
                .sheet(isPresented: $isTagInfoPresented) {
                    TagInfoView()
                }
            }
            .navigationBarTitle(Text(category.name))
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
        CategoryDetailView(category: CategoryViewModel(category: Category(context: Category.viewContext)))
    }
}
