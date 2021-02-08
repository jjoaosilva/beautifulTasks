//
//  Task+CoreDataProperties.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 08/02/21.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

}

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var done: Bool
    @NSManaged public var creationDate: Date?

}

extension Task: Identifiable {

}
