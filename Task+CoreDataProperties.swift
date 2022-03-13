//
//  Task+CoreDataProperties.swift
//  MyFocus
//
//  Created by Eva Sira Madarasz on 13/03/2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
        
        

    }

    @NSManaged public var taskDescription: String?
    @NSManaged public var taskCompleted: Bool
    @NSManaged public var creationDate: Date?
    @NSManaged public var achievedDate: Date?
    @NSManaged public var taskDescription1: Task?
    @NSManaged public var taskCreationDate: Task?
    @NSManaged public var completed: Task?
    @NSManaged public var taskAchievedDate: Task?

}

extension Task : Identifiable {

}
