//
//  CoreDataService.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 08/02/21.
//

import UIKit
import CoreData

class CoreDataService {
    let persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        guard let persistentCointainer = container else {fatalError()}

        return persistentCointainer
    }()

    func create(with data: TaskDTO) -> NSManagedObject? {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {return nil}

        let task = NSManagedObject(entity: entity, insertInto: context)
        task.setValue(data.title, forKey: "title")
        task.setValue(data.subtitle, forKey: "subtitle")
        task.setValue(data.done, forKey: "done")
        task.setValue(data.creationDate, forKey: "creationDate")

        if self.save() {return task}
        return nil
    }

    func delete(_ task: NSManagedObject) -> NSManagedObject? {
        let context = self.persistentContainer.viewContext
        context.delete(task)

        if self.save() {return task}
        return nil
    }

    func searchTasksPerDay(with precidate: NSPredicate) -> [NSManagedObject]? {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//        let dateSort = NSSortDescriptor(key: "creationDate", ascending: false)
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        fetchRequest.sortDescriptors = [doneSort]
        fetchRequest.predicate = precidate

        do {
            let result = try context.fetch(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            return nil
        }
    }

    func save() -> Bool {
        let context = self.persistentContainer.viewContext
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
