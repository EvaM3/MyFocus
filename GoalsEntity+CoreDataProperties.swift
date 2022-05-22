//
//  GoalsEntity+CoreDataProperties.swift
//  MyFocus
//
//  Created by Eva Madarasz on 22/05/2022.
//
//

import Foundation
import CoreData


extension GoalsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalsEntity> {
        return NSFetchRequest<GoalsEntity>(entityName: "GoalsEntity")
    }

    @NSManaged public var goalAchievedDate: Date?
    @NSManaged public var goalCreationDate: Date?
    @NSManaged public var goalCompleted: Bool
    @NSManaged public var goalTitle: String?
    @NSManaged public var goalTasks: String?

}

extension GoalsEntity : Identifiable {

}
