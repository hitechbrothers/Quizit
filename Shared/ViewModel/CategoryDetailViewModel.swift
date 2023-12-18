//
//  CategoryDetailViewModel.swift
//  Quizit
//
//  Created by Diego Acevedo on 11/22/21.
//

import Foundation
import CoreData
import SwiftUI
import Observation

struct RecordViewModel: Identifiable {
    
    let record: Record

    var answer: String {
        return record.wrappedAnswer
    }
    
    var id: NSManagedObjectID {
        return record.objectID
    }
    
    var question: String {
        return record.wrappedQuestion
    }
    
    var category: Category {
        return record.wrappedCategory
    }
    
    var tags: [Tag] {
        return record.tagArray
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

@Observable
class CategoryDetailViewModel /*: ObservableObject */ {
    
    var record_Tag: (record: Record?, tag: Tag?)
    
//    @Published var records = [RecordViewModel]()
    private var records = [RecordViewModel]()
//    @StateObject var settings = UserSettings()
    private var settings = UserSettings()
    
    init(record_Tag: (record: Record?, tag: Tag?) = (nil, nil)) {
        self.record_Tag = record_Tag
    }
    
//    func getRandomRecordPlusRandomTag(category: Category) -> (record: Record?, tag: Tag?) {
    func getRandomRecordPlusRandomTag(category: Category) {

//        var record: Record = Record()
        var record1: Record? = nil
        var tag: Tag? = nil
        let records: [Record] = Record.all(orderBy: "question", predicate: NSPredicate(format: "%K == %@", #keyPath(Record.category.name), category.name ?? "Title_Missing"))
        DispatchQueue.main.async {
            self.records = records.map(RecordViewModel.init)
        }
        
        //Get random record
        record1 = records.randomElement() //still may be an optional. Do not explicitly unwrap. Let view handle it
        
        if var record = record1 {
            //Get random tag
            tag = record.tagArray.randomElement()
            
            //Save the tag to UserDefaults
            let defaults = UserDefaults.standard
            
            //Convert UUID to a string
            let uuidString = tag!.id!.uuidString
//                let encoder = JSONEncoder()
//                if let encoded = try? encoder.encode(tag!.id!.uuidString) {
//                    defaults.set(encoded, forKey: "tag_uuid")
//                    print("settingsTag " + tag!.id!.uuidString)
//                }
            
            //Save the UUID string to UserDefaults
            defaults.set(uuidString, forKey: "tag_uuid")
            print("myUUIDString " + "true " + uuidString)
//                defaults.set(tag!.id!.uuidString, forKey: "tag_uuid")
            
            //pull this out and put into a different method for new button in answer view
            if (settings.isRandom) {
//                record = (record.tagArray.randomElement()?.recordArray.randomElement())! //dosen't make sense, already have the record
                record1 = record

            } else {
                
                //Retrieve the UUID string from UserDefaults
                let defaults = UserDefaults.standard
                if let savedUUIDString = defaults.string(forKey: "tag_uuid") {
                    
                    print("myUUIDString " + "false " + savedUUIDString)
                    
                    //Convert the UUID string back to UUID
                    if let savedUUID = UUID(uuidString: savedUUIDString) {
                        //Use the savedUUID variable here
                        tag = Record.getByUUID(with: savedUUID)
                        
    //                    //Get a random record from tag
    //                    record = tag!.recordArray.randomElement()
                        
                        //Try this
                        let tagPredicate = NSPredicate(format: "tags = %@", tag!.wrappedName)
                        let nsRecords = records as NSArray
                        let filterdRecords = nsRecords.filtered(using: tagPredicate)
                        record = (filterdRecords as! [Record]).randomElement()!
                    }
                }
    //            if let udid = defaults.string(forKey: "tag_uuid") {
    //                print("settingsTag" + udid)
    //            }
                

                
    //            if let udid = defaults.object(forKey: "tag_uuid") as? Data {
                    
    //                let decoder = JSONDecoder()
                    
    //                let decoder = JSONDecoder()
    //                let product = try decoder.decode(GroceryProduct.self, from: json)
                    

    //                if let settingsTag = try? decoder.decode(SettingsTag.self, from: udid) {
    //
    //
    //                    print("settingsTag " + settingsTag.id)
    //
    //
    //
    //                    /*
    //                     get a tag by uuid
    //                     use predicate if possible
    //                     */
    //
    //                    //predicate on array here
    ////                    let lastNameKinomotoPredicate = NSPredicate(format: "lastName = %@", "Kinomoto")
    ////                    let lastNameKinomoto = nsPeople.filtered(using: lastNameKinomotoPredicate)
    ////                    let tagPredicate = NSPredicate(format: "tags = %@", "Math")  //this may be wrong
    //                    /*
    //                    let tagPredicate = NSPredicate(format: "tags = %@", settingsTag.id)  //this may be wrong should be a tag name not an id
    //                    let nsRecords = records as NSArray
    //                    let filterdRecords = nsRecords.filtered(using: tagPredicate)
    ////                    lastNameBeginsKino as! [Person]
    //                    let records = filterdRecords as! [Record]
    //                    record = records.randomElement() //still may be an optional. Do not explicitly unwrap. Let view handle it
    //                     */
    //
    ////                    print("settingsTag" + settingsTag.id)
    //                }
    //            }
                
            }
        } else {
            tag = nil
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
        
        

//        if (settings.isRandom) {

//            print("Settings true")

//            let tag = SettingsTag(name: "Scriptures")
//            let encoder = JSONEncoder()
//            let defaults = UserDefaults.standard
//
//            if let encoded = try? encoder.encode(tag) {
//                defaults.set(encoded, forKey: "savedTag")
//            }

        self.record_Tag.record = record1
        self.record_Tag.tag = tag
//        return (record1, tag) //Don't forget to return tag from else
        


//        } else {
//
//            //perform predicate on records array based on any tag
//
////            let defaults = UserDefaults.standard
////
////            if let savedTag = defaults.object(forKey: "savedTag") as? Data {
////                let decoder = JSONDecoder()
////                if let loadedTag = try? decoder.decode(SettingsTag.self, from: savedTag) {
////                    print(loadedTag.name)  //for testing
////                }
////            }
//
//
//            //
//            if let udid = UserDefaults.standard.value(forKey: "MY_UUID") as? String, !udid.isEmpty {
//                // Use it...
//            } else {
//                let udid = UUID().uuidString
//                UserDefaults.standard.set(udid, forKey: "MY_UUID")
//            }
//            //
//
//            let defaults = UserDefaults.standard
//
//            if let udid = defaults.object(forKey: "tag_uuid") as? Data {
//                let decoder = JSONDecoder()
//
//                if let settingsTag = try? decoder.decode(SettingsTag.self, from: udid) {
//                    print(settingsTag.id)
//
//
//                    /*
//                     get a tag by uuid
//                     use predicate if possible
//                     */
//
//                    //predicate on array here
////                    let lastNameKinomotoPredicate = NSPredicate(format: "lastName = %@", "Kinomoto")
////                    let lastNameKinomoto = nsPeople.filtered(using: lastNameKinomotoPredicate)
////                    let tagPredicate = NSPredicate(format: "tags = %@", "Math")  //this may be wrong
//                    let tagPredicate = NSPredicate(format: "tags = %@", settingsTag.id)  //this may be wrong should be a tag name not an id
//                    let nsRecords = records as NSArray
//                    let filterdRecords = nsRecords.filtered(using: tagPredicate)
////                    lastNameBeginsKino as! [Person]
//                    let records = filterdRecords as! [Record]
//                    record = records.randomElement() //still may be an optional. Do not explicitly unwrap. Let view handle it
//                }
//            }
//
//            return record
//        }

//        let record = records.randomElement()
//        return record ?? Record()


//        record?.question ?? "<no_question>"
    }
}
