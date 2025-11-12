//
//  DataController.swift
//  JFCTasks
//
//  Created by Monty Carlo Pineda on 11/13/25.
//

import CoreData

struct DataController {
    static let shared = DataController()
    
    func isEmptyEntity(name: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            return count == 0
        } catch {
            print("Error checking if empty for entity \(name): \(error)")
            return true
        }
    }
    
    func addInitialData(container: NSPersistentContainer) {
        let context = container.viewContext
        
        if isEmptyEntity(name: "Category", context: context) {
            container.performBackgroundTask { context in
                let batchRequest = self.categoriesBatchRequest()
                
                do {
                    try context.execute(batchRequest)
                } catch {
                    print("Error executing Categories batch request: \(error.localizedDescription)")
                }
            }
        }
        
        if isEmptyEntity(name: "Tag", context: context) {
            let batchRequest = self.tagsBatchRequest()
            
            do {
                try context.execute(batchRequest)
            } catch {
                print("Error executing Tags batch request: \(error.localizedDescription)")
            }
        }
    }
    
    private func tagsBatchRequest() -> NSBatchInsertRequest {
        let tags = ["Tag 1", "Tag 2", "Tag 3", "Tag 4", "Tag 5"]
        let total = tags.count
        var index = 0
        
        let batchRequest = NSBatchInsertRequest(entity: Tag.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }
            
            if let tag = managedObject as? Tag {
                let data = tags[index]
                tag.name = data
            }
            
            index += 1
            return false
        }
        
        return batchRequest
    }
    
    private func categoriesBatchRequest() -> NSBatchInsertRequest {
        let categories = ["Category 1", "Category 2", "Category 3"]
        let total = categories.count
        var index = 0
        
        let batchRequest = NSBatchInsertRequest(entity: Category.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }
            
            if let tag = managedObject as? Category {
                let data = categories[index]
                tag.name = data
            }
            
            index += 1
            return false
        }
        
        return batchRequest
    }
}
