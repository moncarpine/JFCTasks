//
//  CategoryView.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import SwiftUI


struct CategoryView: View {
    @Environment(\.managedObjectContext) private var context

    @StateObject var viewModel: CategoryViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Categories")) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        NavigationLink {
                            Text("Item at \(category.name ?? "Unknown")")
                        } label: {
                            HStack {
                                Text(category.name ?? "Unknown")
                                Spacer()
                                
                                Button {
                                    print("edit tags")
                                } label: {
                                    Image(systemName: "pencil")
                                }
                                .padding(.trailing, 8)
                                .buttonStyle(.borderless)
                                
                                Button(role: .destructive) {
                                    print("delete tags")
                                    viewModel.deleteCategory(category)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .padding(.trailing, 8)
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                }
                .headerProminence(.increased)
            }
        }
    }
}
