//
//  TagView.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import SwiftUI

struct TagView: View {
    @Environment(\.managedObjectContext) private var context

    @StateObject var viewModel: TagViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tags, id: \.self) { tag in
                    NavigationLink {
                        Text("Item at \(tag.name ?? "Unknown")")
                    } label: {
                        HStack {
                            Text(tag.name ?? "Unknown")
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
                                viewModel.deleteTag(tag)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .padding(.trailing, 8)
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
        }
    }
}
