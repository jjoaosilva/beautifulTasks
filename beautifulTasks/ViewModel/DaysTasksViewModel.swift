//
//  DaysTasksViewModel.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 12/02/21.
//

import Foundation
// swiftlint:disable force_cast line_length

class DaysTasksViewModel {
    var coreDataService: CoreDataService = CoreDataService()
    var taskList: [TaskDTO] = []
    var date: String
    var concludeTasks: Int = 0
    var pendingdTasks: Int = 0

    var handleUpdate: (() -> Void)?

    init() {
        let date = Date()
        let format = DateFormatter()
        format.locale = Locale(identifier: "pt_BR")
        format.setLocalizedDateFormatFromTemplate("EEEEMMMMd")
        let formattedDate = format.string(from: date)

        self.date = formattedDate.capitalized
    }
}

extension DaysTasksViewModel {
    public func getAllTasksDay() {
        let date = Date()
        let calendar = NSCalendar.current
        let startDate = calendar.startOfDay(for: date)

        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate, wrappingComponents: true) // dia 11
        let predicate = NSPredicate(format: "creationDate >= %@ AND creationDate <= %@", startDate as CVarArg, endDate! as CVarArg)

        let results = self.coreDataService.searchTasksPerDay(with: predicate)

        if let tasksResults = results {
            self.taskList = tasksResults.map { task in
                TaskDTO(task as! Task)
            }
        }

        self.updateStatusTask()
    }

    public func handleTask(at index: Int) {
        let updateTask = self.taskList[index].task!
        updateTask.done = !updateTask.done
        _ = self.coreDataService.save()
    }

    public func deleteTask(at index: Int) -> Bool {
        let result = self.coreDataService.delete(self.taskList[index].task!)
        if result == nil { return false }
        self.taskList.remove(at: index)
        return true
    }

    private func updateStatusTask() {
        self.concludeTasks = self.taskList.reduce(0) {$1.done ? $0 + 1 : 0}
        self.pendingdTasks = self.taskList.count - concludeTasks
    }
}

extension DaysTasksViewModel: UpdateTask {
    func updateCheck(to index: Int) {
        self.handleTask(at: index)
        self.getAllTasksDay()
        self.handleUpdate?()
    }
}
