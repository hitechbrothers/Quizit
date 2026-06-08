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
                
                let record = categoryDetailVM.getRecord(categoryVM: categoryVM)

                List {

                    HStack {
                        Button(action: {
                            self.isTagQuestionPresented = true
                        }) {
                            HStack {
//                                Text(tag!.name ?? "<no_tag>")
//                                Text("Some tag")
//                                Text(record.tags!.name ?? "<no_tag>")
//                                Text(record!.tags!.name ?? "<no_tag>")
                                let defaults = UserDefaults.standard
                                let uuid_string = defaults.string(forKey: "tag_uuid")
                                let tag: Tag? = Tag.getByUUID(with: UUID(uuidString: uuid_string!))
                                let tagName: String = tag!.name!
                                    
                                    
                                    if let record = record {
                                        //                                    Text(record.tags!.name!)  //If your looking for a member of NSSet learn about NSSet
                                        //                                    Text(record.category!.name!) //test
                                        
//                                        if record.tags!.contains(tagName) {
                                        

//                                        }
                                        
                                        //understand how the app work before deciding what to put here
                                        Text(tagName) //If your looking for a member of NSSet learn about NSSet
                                            .foregroundColor(.blue)
                                        
                                        
                                    }
                                    else {
                                        Text("<no_tag>")
                                            .foregroundColor(.blue)
                                    }
//                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.lightGray))
                    
                    VStack {
                        Text("Question")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        if let record = record {
                            Text(record.question!)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        else {
                            Text("<no_question>")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(5)

//                    Text(record.question ?? "<no_question>")
//                    Text(record.category?.name ?? "<no_category>")
                    
//                    if let record = record {
//                        Text(record.question!)
//                    }
//                    else {
//                        Text("<no_question>")
//                    }
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
