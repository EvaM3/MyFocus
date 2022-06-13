//
//  TaskEntity+CoreDataProperties.swift
//  MyFocus
//
//  Created by Eva Sira Madarasz on 22/05/2022.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var achievedDate: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var creationDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

    
    public var taskAchievedDate: Date? {
        achievedDate
    }
    
    public var taskCreationDate: Date? {
        creationDate ?? Date()
    }
    
    public var taskName: String? {
        name ?? "Unknown"
    }
    
    public var taskId: UUID {
        id ?? UUID()
    }
    
    
}

extension TaskEntity : Identifiable {

}
