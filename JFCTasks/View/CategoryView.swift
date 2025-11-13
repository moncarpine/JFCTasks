//
//  CategoryView.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel: CategoryViewModel
    
    @State private var showSheet = false
    @State private var selectedCategory: Category?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    Button {
                        selectedCategory = category
                        showSheet = true
                    } label: {
                        Text(category.name ?? "Unknown")
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet, onDismiss: toggleEditing) {
                if let category = selectedCategory {
                    EditCategoryView(viewModel: viewModel, showSheet: $showSheet, category: category)
                        .presentationDetents([.fraction(0.3)])
                } else {
                    AddCategoryView(viewModel: viewModel, showSheet: $showSheet)
                        .presentationDetents([.fraction(0.3)])
                }
            }
        }
        .onChange(of: selectedCategory) { print($0?.name ?? "") }
    }
    
    private func toggleEditing() {
        selectedCategory = nil
    }
}

struct AddCategoryView: View {
    @ObservedObject var viewModel: CategoryViewModel
    
    @Binding var showSheet: Bool
    
    @State private var categoryName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Category Name", text: $categoryName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .navigationTitle("Add Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addCategory(name: categoryName)
                        showSheet = false
                    }
                    .disabled(categoryName.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showSheet = false
                    }
                }
            }
        }
    }
}

struct EditCategoryView: View {
    @ObservedObject var viewModel: CategoryViewModel
    
    @Binding var showSheet: Bool
    
    @State var category: Category
    @State private var categoryName = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Category Name", text: $categoryName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button("Delete") {
                    viewModel.deleteCategory(category)
                    showSheet = false
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Edit Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateCategory(category, to: categoryName)
                        showSheet = false
                    }
                    .disabled(categoryName.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showSheet = false
                    }
                }
            }
        }
    }
}
