//
//  QuizitApp.swift
//  Quizit
//
//  Created by Diego Acevedo on 2/1/21.
//

import SwiftUI
import CoreData

@main
struct QuizitApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
          
            //Try this code
            persistenceController.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            persistenceController.container.viewContext.automaticallyMergesChangesFromParent = true
        }
    }
}
