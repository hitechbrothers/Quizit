//
//  Quizit_iOSApp.swift
//  Quizit-iOS
//
//  Created by Diego Acevedo on 12/26/22.
//

import SwiftUI

@main
struct Quizit_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
