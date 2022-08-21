//
//  AddQuestionView.swift
//  Quizit
//
//  Created by Diego Acevedo on 3/19/21.
//

import SwiftUI
import CoreData

struct AddQuestionView: View {
    
    let categoryVM: CategoryViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addQuestionVM = AddRecordViewModel()

    
//    var context: NSManagedObjectContext
//    let category: Category

//    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default)
//    private var catagories: FetchedResults<Category>
    
//    @State private var newQuestion: String = ""
//    @State private var newAnswer: String = ""
//    @EnvironmentObject var record: ObservedRecord
    
//    @State var selectedCategory: Category
    
    var body: some View {
        VStack {
            HStack {
                Button(action: self.onCancelTapped) {Text("Cancel")}
                .padding(.leading)
                Spacer()
                Text("Add Question")
                Spacer()
                Button(action: self.onSaveTapped) {
                    Text("Save")
                }
                .padding(.trailing)
            }
            TextField("New Question", text: $addQuestionVM.question)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            TextField("New Answer", text: $addQuestionVM.answer)
              .disableAutocorrection(true)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding()
//            Picker("Please choose a category", selection: $selectedCategory) {
//                ForEach(self.catagories) { category in
//                    Text(category.name!)
//                }
//            }
//            Text("You selected: \(selectedCategory.name!)")
            
          Spacer()
        }
        .padding(.top, 25.0)
    }
    
    private func onSaveTapped() {
        
        if (self.addQuestionVM.question.isEmpty) {
            return
        }
        else if (self.addQuestionVM.answer.isEmpty) {
            return
        }
        
        addQuestionVM.save(category: categoryVM.category)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }

    
    
    
//    private func onSaveTapped() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        
//        let newRecord = Record(context: self.context)
//        let newCategory = Category(context: self.context)
//        newCategory.addToRecord(<#T##value: Record##Record#>)
//        let newTag = Tag(context: self.context)
//        newTag.name = "Prophecy"
//        newTag.id = UUID()
        
//        newRecord.answer = self.newAnswer
//        newRecord.id = UUID()
//        newRecord.question = self.newQuestion
//        newRecord.category = category
//        newRecord.tag = newTag
//        category.addToRecord(newRecord)
//        newRecord.category = Category(context: self.context)
        
        
//        newRecord.category = record.refObj.category //not sure about this
//        newRecord.category?.name = "Test1"
//        newRecord.category?.id = UUID() //shouldn't do this
        
        /*
         // Get CategoryRootViewController's object
         QuizitAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
         CategoryRootViewController *categoryRootViewController = [delegate categoryRootViewController];
         
         NSMutableArray *categoryArray = categoryRootViewController.categoryArray;
         Category *category = (Category *)[categoryArray objectAtIndex:QuizitModel.catIndex];
   
   [self.aRecord setCategory:category];
         */
        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//
//        self.presentationMode.wrappedValue.dismiss()
//    }
//
//    private func onCancelTapped() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
//}

//struct AddQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        let stack = PersistenceController()
//        AddQuestionView(context: stack.container.viewContext)
//    }
}
