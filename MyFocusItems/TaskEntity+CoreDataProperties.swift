//
//  TaskEntity+CoreDataProperties.swift
//  MyFocus
//
//  Created by Eva Sira Madarasz on 20/03/2022.
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

}

extension TaskEntity : Identifiable {

}
