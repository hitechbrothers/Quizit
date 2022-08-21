//
//  CategoryDetailViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/22/21.
//

import Foundation
import CoreData
import SwiftUI

struct RecordViewModel: Identifiable {
    
    let record: Record
    
    var question: String {
        return record.question ?? ""
    }
    
    var category: Category {
        return record.category ?? Category()
    }
    
    var id: NSManagedObjectID {
        return record.objectID
    }
}

//class CategoryDetailViewModel: ObservableObject {
//
//    @Published var records = [RecordViewModel]()
////    @ObservedObject var settings = UserSettings()
//    @Published var settings = UserSettings()
//
//
//    func getRandomRecord() -> Record {
//
//        let records: [Record] = Record.all(orderBy: "question")
//        let record: Record
//        DispatchQueue.main.async {
//            self.records = records.map(RecordViewModel.init)
//        }
//
////        if $settings.isRandom.wrappedValue {
////            record = records.randomElement()
////        }
//
//
//        return record ?? Record()
////        record = records.randomElement()!
////        return $settings.isRandom ? record : Record()
//
////        let record = records.randomElement()
////        return record ?? Record()
////        record?.question ?? "<no_question>"
//
//    }

struct SettingsTag: Codable {
    var id: String
}

class CategoryDetailViewModel: ObservableObject {

    @Published var records = [RecordViewModel]()
//    @StateObject var settings = UserSettings()
    var settings = UserSettings()

    func getRecord(categoryVM: CategoryViewModel) -> Record? {

//        var record: Record = Record()
        var record: Record? = nil
        let records: [Record] = Record.all(orderBy: "question", predicate: NSPredicate(format: "%K == %@", #keyPath(Record.category.name), categoryVM.name))
        DispatchQueue.main.async {
            self.records = records.map(RecordViewModel.init)
        }

        /* start test */
//            let tag = SettingsTag(name: "Angels")
//            let encoder = JSONEncoder()
//            let defaults = UserDefaults.standard
//
//            if let encoded = try? encoder.encode(tag) {
//                defaults.set(encoded, forKey: "savedTag")
//            }
        
//        record = records.randomElement() //still may be an optional. Do not explicitly unwrap
        
        
        
//        return record
        
//        let dummyRecord = Record(context: Record.viewContext)
//        dummyRecord.question = ""
//        dummyRecord.answer = ""
//        dummyRecord.id = UUID()
        

//        return record ?? Record()
//        return record ?? dummyRecord //dummyRecord creates too many uneccessary records
//        return record ?? Record(context: Record.viewContext)  //unwrap here
//        return record ?? Record()
//        return record



        /* end test */

        if (settings.isRandom) {

//            print("Settings true")

//            let tag = SettingsTag(name: "Scriptures")
//            let encoder = JSONEncoder()
//            let defaults = UserDefaults.standard
//
//            if let encoded = try? encoder.encode(tag) {
//                defaults.set(encoded, forKey: "savedTag")
//            }



            
            record = records.randomElement() //still may be an optional. Do not explicitly unwrap. Let view handle it
            return record

        } else {

            //perform predicate on records array based on any tag
            
//            let defaults = UserDefaults.standard
//
//            if let savedTag = defaults.object(forKey: "savedTag") as? Data {
//                let decoder = JSONDecoder()
//                if let loadedTag = try? decoder.decode(SettingsTag.self, from: savedTag) {
//                    print(loadedTag.name)  //for testing
//                }
//            }
            
            
            //
            if let udid = UserDefaults.standard.value(forKey: "MY_UUID") as? String, !udid.isEmpty {
                // Use it...
            } else {
                let udid = UUID().uuidString
                UserDefaults.standard.set(udid, forKey: "MY_UUID")
            }
            //

            let defaults = UserDefaults.standard
            
            if let udid = defaults.object(forKey: "tag_uuid") as? Data {
                let decoder = JSONDecoder()
                                
                if let settingsTag = try? decoder.decode(SettingsTag.self, from: udid) {
                    print(settingsTag.id)
                    
                    
                    /*
                     get a tag by uuid
                     use predicate if possible
                     */

                    //predicat on array here
//                    let lastNameKinomotoPredicate = NSPredicate(format: "lastName = %@", "Kinomoto")
//                    let lastNameKinomoto = nsPeople.filtered(using: lastNameKinomotoPredicate)
//                    let tagPredicate = NSPredicate(format: "tags = %@", "Math")  //this may be wrong
                    let tagPredicate = NSPredicate(format: "tags = %@", settingsTag.id)  //this may be wrong should be a tag name not an id
                    let nsRecords = records as NSArray
                    let filterdRecords = nsRecords.filtered(using: tagPredicate)
//                    lastNameBeginsKino as! [Person]
                    let records = filterdRecords as! [Record]
                    record = records.randomElement() //still may be an optional. Do not explicitly unwrap. Let view handle it
                }
            }

            return record
        }

//        let record = records.randomElement()
//        return record ?? Record()


//        record?.question ?? "<no_question>"
    }
}
