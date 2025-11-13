//
//  TagViewModel.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import CoreData

class TagViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    @Published var tags = [Tag]()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchTags()
    }
    
    private func fetchTags() {
        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
        
        do {
            tags = try context.fetch(request)
        } catch {
            print("Failed to fetch Tags: \(error.localizedDescription)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
            fetchTags()
        } catch {
            print("Failed to save Tags: \(error.localizedDescription)")
        }
    }
    
    func addTag(name: String) {
        let tag = Tag(context: context)
        tag.name = name
        
        saveContext()
    }
    
    func updateTag(_ tag: Tag, to newName: String) {
        tag.name = newName
        
        saveContext()
    }
    
    func deleteTag(_ tag: Tag) {
        context.delete(tag)
        
        saveContext()
    }
    
//    private func fetchTagByName(_ name: String) -> Tag? {
//        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
//        request.predicate = NSPredicate(format: "name == %@", name)
//
//        do {
//            let tags = try context.fetch(request)
//            if let tag = tags.first {
//                return tag
//            } else {
//                return nil
//            }
//        } catch {
//            print("Failed to fetch Tag: \(error.localizedDescription)")
//        }
//
//        return nil
//    }
}
