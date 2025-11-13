//
//  HomeView.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Task List") {
                    
                }
                NavigationLink("People") {
                    
                }
                NavigationLink("Business") {
                    
                }
                NavigationLink("Tags") {
                    TagView(viewModel: TagViewModel(context: context))
                }
                NavigationLink("Categories") {
                    CategoryView(viewModel: CategoryViewModel(context: context))
                }
            }
            .navigationTitle("Contacts & Tasks")
        }
    }
}
