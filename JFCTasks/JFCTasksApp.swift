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
            CategoryView(viewModel: CategoryViewModel(context: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
