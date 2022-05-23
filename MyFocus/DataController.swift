//
//  DataController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 18/05/2022.
//


import CoreData


class CoreDataManager {
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FocusData")
        
        container.loadPersistentStores(completionHandler: { (NSPersistentStoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error)")
            }
        })
        return container
    }()
    
    
    func saveData() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    func loadData(predicate: NSPredicate? = nil) -> [TaskEntity] {
        let request : NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = predicate
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error loading data \(error)")
            return []
        }
    }
    
    func loadGoalData(predicate: NSPredicate? = nil) -> [GoalsEntity] {
        let request: NSFetchRequest<GoalsEntity> = GoalsEntity.fetchRequest()
        request.predicate = predicate
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error loading data \(error)")
            return []
        }
    }

    func addItem(item: ListEntityUI) {
        let newItem = TaskEntity(context: persistentContainer.viewContext)
        newItem.name = item.title
        newItem.creationDate = item.creationDate
        newItem.achievedDate = item.achievedDate
        saveData()
    }
    
    func deleteData(at index: Int) {
        let loadedData = loadData()
        let selectedTask = loadedData[index]
        persistentContainer.viewContext.delete(selectedTask)
        self.saveData()
    }
    
    func updateData(at index: Int, title: String) {
        let loadedData = loadData()
        let selectedTask = loadedData[index]
        selectedTask.name = title
        
        self.saveData()
        
    }
    
}
