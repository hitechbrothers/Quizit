//
//  UserSettings.swift
//  Quizit
//
//  Created by Diego Acevedo on 7/14/21.
//

import Foundation
//import Combine

class UserSettings: ObservableObject {
    
    @Published var isRandom: Bool {
        didSet {
            UserDefaults.standard.set(isRandom, forKey: "isRandomTags")
        }
    }
    
    init() {
        self.isRandom = UserDefaults.standard.object(forKey: "isRandomTags") as? Bool ?? true
    }
}
