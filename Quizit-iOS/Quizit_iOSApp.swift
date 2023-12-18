//
//  Quizit_iOSApp.swift
//  Quizit-iOS
//
//  Created by Diego Acevedo on 12/26/22.
//

import SwiftUI
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        MKiCloudSync.start(withPrefix: "sync")
        return true
    }
}

@main
struct QuizitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
            
            //Try this code
            persistenceController.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            persistenceController.container.viewContext.automaticallyMergesChangesFromParent = true
        }
    }
}

