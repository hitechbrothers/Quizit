//
//  Quizit_macOSApp.swift
//  Quizit-macOS
//
//  Created by Diego Acevedo on 12/26/22.
//

import SwiftUI

@main
struct Quizit_macOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
