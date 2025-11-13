//
//  JFCTasksApp.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/12/25.
//

import SwiftUI

@main
struct JFCTasksApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        DataController.shared.addInitialData(container: persistenceController.container)
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
