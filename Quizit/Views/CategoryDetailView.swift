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
    
    // someDate would be a date object that represents the movie's max age
//    let oldMoviesPredicate = NSPredicate(format: "%K <= %@", #keyPath(Movie.releaseDate), someDate as NSDate)
    
    @FetchRequest(
        entity: Tag.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tag.name, ascending: true),
//            animation: .default
        ],
//        predicate: NSPredicate(format: "name = %@ && school = %@", "Tom", school)
        predicate: NSPredicate(format: "name = %@", "Holy Spirit")
    ) var tags: FetchedResults<Tag>
    
    
//    let request: NSFetchRequest<Tag> = Tag.fetchRequest()
    
//    let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
    
//    let request = NSFetchRequest<Tag>(entityName: "Tag")
//    let requestPredicate = NSPredicate(format: "name == %@", "Angel")
    
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
//                        let tags = try? context.fetch(self.request)
//                        let tag = tags?.randomElement()
                        let tag = tags.randomElement()


                        Text(tag!.name ?? "<no_tag>")
                            .foregroundColor(.blue)
                    }
                    .listRowBackground(Color(UIColor.lightGray))
                    
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
