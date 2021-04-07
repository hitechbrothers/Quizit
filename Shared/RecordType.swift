//
//  RecordType.swift
//  Quizit
//
//  Created by Diego Acevedo on 3/21/21.
//

import SwiftUI

class RecordType: Identifiable, Codable {
    var question = ""
    var answer = ""
    @NSManaged public var category: Category?
    var id = UUID()
}

class ObservedRecord: ObservableObject {
    @Published var refObj = RecordType()
}
