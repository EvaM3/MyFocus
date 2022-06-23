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
    
    func loadGoal(predicate: NSPredicate? = nil) -> [Goal] {
        let request : NSFetchRequest<GoalEntity> =  GoalEntity.fetchRequest()
        request.predicate = predicate
        do {
            let goalEntities = try persistentContainer.viewContext.fetch(request)
            let goals = goalEntities.map { goalEntity in
                mapToGoal(entity: goalEntity)
            }
            return goals
        } catch {
            print("Error loading data \(error)")
            return []
        }
      
    }
    
    func loadGoalData(predicate: NSPredicate? = nil) -> [GoalEntity] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
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
        let loadedData = loadGoal()
        let selectedTask = loadedData[index]
      //  persistentContainer.viewContext.delete(selectedTask)
        self.saveData()
    }

    func updateData(at index: Int, title: String) {
        let loadedData = loadGoal()
        let selectedTask = loadedData[index]
     //   selectedTask.name = title

        self.saveData()

    }
    
    
    func generateRandomData() {
        var randomGoals = [GoalEntity]()
        for i in 0...Int.random(in: 1..<3) {
            var currentDate: Date
            switch i {
            case 0:
                currentDate = Date()
            case 1:
                currentDate = getYesterdayDate()
            case 2:
                currentDate = getTomorrowDate()
            default:
                currentDate = getYesterdayDate()
            }
            randomGoals.append(makeRandomGoal(createDate: currentDate))
            
        }
        
        self.saveData()
    }
    
    func makeRandomTask(createDate: Date) -> TaskEntity {
        let randomTask = TaskEntity(context: persistentContainer.viewContext)
        randomTask.name = "Finish the book \(UUID().uuidString)"
        randomTask.creationDate = createDate
        randomTask.achievedDate = nil
        return randomTask
    }
    
    func makeRandomGoal(createDate: Date) -> GoalEntity {
        var randomTasks = [TaskEntity]()
        for _ in 0...Int.random(in: 1...2) {
            randomTasks.append(makeRandomTask(createDate: createDate))
        }
        let randomGoal = GoalEntity(context: persistentContainer.viewContext)
        randomGoal.title = "Write the essay \(UUID().uuidString)"
        randomGoal.creationDate = createDate
        randomGoal.achievedDate = nil
        for randomTask in randomTasks {
            randomGoal.addToTasks(randomTask)
        }
        return randomGoal
    }
    
    func mapToGoal(entity: GoalEntity) -> Goal {
        var goalTasks: [Task] = []
        if let tasks = entity.tasks?.array as? [TaskEntity] {
            for task in tasks {
                let newTask: Task = Task(id: task.taskId, title: task.taskName ?? "Unknown", completed: task.completed, creationDate: task.taskCreationDate ?? Date(), achievedDate: task.taskAchievedDate)
                goalTasks.append(newTask)
            }
        }
        let goal: Goal = Goal(id: entity.defaultId , tasks: goalTasks, title: entity.defaultTitle, completed: entity.isCompleted, creationDate: entity.defaultCreationDate, achievedDate: entity.defaultAchievedDate)
        
        return goal
    }
    
    func mapToGoalEntity(goal: Goal) -> GoalEntity {
        var taskEntities: [TaskEntity] = []
        
        for task in goal.tasks {
            let newTaskEntity = mapToTaskEntity(item: task)
            taskEntities.append(newTaskEntity)
        }
        let newGoal = GoalEntity(context: persistentContainer.viewContext)
        newGoal.id = goal.id
        newGoal.title = goal.title
        newGoal.creationDate = goal.creationDate
        newGoal.achievedDate = goal.achievedDate
        newGoal.completed = goal.completed
        newGoal.insertIntoTasks(taskEntities, at: NSIndexSet(indexesIn: NSRange(location: 0, length: taskEntities.count)))
        
        return newGoal
    }
    
    func mapToTaskEntity(item: Task) -> TaskEntity {
        let newItem = TaskEntity(context: persistentContainer.viewContext)
        newItem.id = item.id
        newItem.name = item.title
        newItem.creationDate = item.creationDate
        newItem.achievedDate = item.achievedDate
        newItem.completed = item.completed
        
        return newItem
    }
    
    
    func getYesterdayDate() -> Date {
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
        return yesterdayDate
    }
    
    func getTomorrowDate() -> Date {
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: +1 , to: Date()) ?? Date() + 86400
        return tomorrowDate
    }
    
}
