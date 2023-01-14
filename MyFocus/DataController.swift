//
//  DataController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 18/05/2022.
//


import CoreData


protocol CoreDataLoaderProtocol {
    func loadGoal(predicate: NSPredicate?) -> [Goal]
}

protocol CoreDataUpdaterProtocol {
    func createGoal(goal: Goal)
    func updateGoal(goal: Goal)
    func deleteGoal(id: UUID)
}


class CoreDataManager: CoreDataLoaderProtocol, CoreDataUpdaterProtocol {
    
    
    private let persistentContainer: NSPersistentContainer
    
 
    
    init(persistentContainer: NSPersistentContainer? = nil) {
        self.persistentContainer = persistentContainer ?? Self.makePersistentContainer()
    }
    
    private static func makePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "FocusData")
        
        container.loadPersistentStores(completionHandler: { (NSPersistentStoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error)")
            }
        })
        return container
    }
    
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
    
    func createGoal(goal: Goal) {
        if goal.id == nil {
        let _ = mapToGoalEntity(goal: goal)
        // solution based on id
        } else {
            return
        }
        saveData()
      
    }
    
    
    func updateGoal(goal: Goal) {
        let loadedGoal = loadGoal()
        let updatedGoal = loadedGoal[0].title
    }
    
    func deleteGoal(id: UUID) {
        
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
        self.saveData()
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
        let tomorrowsDate = Calendar.current.date(byAdding: .day, value: +1 , to: Date()) ?? Date() + 86400
        return tomorrowsDate
    }
    
    
}
