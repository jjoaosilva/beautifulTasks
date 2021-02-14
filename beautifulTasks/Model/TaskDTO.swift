//
//  TaskDTO.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 08/02/21.
//

import Foundation

struct TaskDTO: Equatable {
    var title: String
    var subtitle: String
    var done: Bool
    var creationDate: Date

    var task: Task?
}

extension TaskDTO {
     init(_ task: Task) {
        self.title = task.title ?? ""
        self.subtitle = task.subtitle ?? ""
        self.done = task.done
        self.creationDate = task.creationDate ?? Date()

        self.task = task
    }

}
