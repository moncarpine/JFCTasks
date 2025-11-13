//
//  CategoryViewModel.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import CoreData

class CategoryViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    @Published var categories = [Category]()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchCategories()
    }
    
    private func fetchCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Failed to fetch Categories: \(error.localizedDescription)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
            fetchCategories()
        } catch {
            print("Failed to save Categories: \(error.localizedDescription)")
        }
    }

    func addCategory(name: String) {
        let category = Category(context: context)
        category.name = name
        
        saveContext()
    }
    
    func updateCategory(_ category: Category, to newName: String) {
        category.name = newName
        
        saveContext()
    }
    
    func deleteCategory(_ category: Category) {
        context.delete(category)
        
        saveContext()
    }
    
    //    func fetchCategoryByName(_ name: String) -> Category? {
    //        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    //
    //        do {
    //            let categories = try context.fetch(fetchRequest)
    //            if let category = categories.first {
    //                return category
    //            } else {
    //                return nil
    //            }
    //        } catch {
    //            print("Failed to fetch Category: \(error.localizedDescription)")
    //        }
    //
    //        return nil
    //    }
}
