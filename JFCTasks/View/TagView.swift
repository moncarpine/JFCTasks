//
//  TagView.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import SwiftUI

struct TagView: View {
    @StateObject var viewModel: TagViewModel
    
    @State private var showSheet = false
    @State private var selectedTag: Tag?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tags, id: \.self) { tag in
                    Button {
                        selectedTag = tag
                        showSheet = true
                    } label: {
                        Text(tag.name ?? "Unknown")
                    }
                }
            }
            .navigationTitle("Tags")
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
                if let tag = selectedTag {
                    EditTagView(viewModel: viewModel, showSheet: $showSheet, tag: tag)
                        .presentationDetents([.fraction(0.3)])
                } else {
                    AddTagView(viewModel: viewModel, showSheet: $showSheet)
                        .presentationDetents([.fraction(0.3)])
                }
            }
        }
        .onChange(of: selectedTag) { print($0?.name ?? "") }
    }
    
    private func toggleEditing() {
        selectedTag = nil
    }
}

struct AddTagView: View {
    @ObservedObject var viewModel: TagViewModel
    
    @Binding var showSheet: Bool
    
    @State private var tagName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Tag Name", text: $tagName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .navigationTitle("Add Tag")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addTag(name: tagName)
                        showSheet = false
                    }
                    .disabled(tagName.isEmpty)
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

struct EditTagView: View {
    @ObservedObject var viewModel: TagViewModel
    
    @Binding var showSheet: Bool
    
    @State var tag: Tag
    @State private var tagName = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Tag Name", text: $tagName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button("Delete") {
                    viewModel.deleteTag(tag)
                    showSheet = false
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Edit Tag")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateTag(tag, to: tagName)
                        showSheet = false
                    }
                    .disabled(tagName.isEmpty)
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
