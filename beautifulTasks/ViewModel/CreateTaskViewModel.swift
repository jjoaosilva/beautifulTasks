//
//  CreateTaskViewModel.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 13/02/21.
//

import Foundation

class CreateTaskViewModel {
    var coreDataService: CoreDataService = CoreDataService()
    let netWorkService: BoredRequest = BoredRequest()
    var title: String = ""
    var description: String = ""

    public var handleDismiss: (() -> Void)?
}

extension CreateTaskViewModel {

    @objc func cancel() {
        self.handleDismiss?()
    }

    @objc func save() {
        let task = TaskDTO(title: self.title, subtitle: self.description, done: false, creationDate: Date())
        _ = self.coreDataService.create(with: task)
        self.handleDismiss?()
    }

    public func getBoredTask(completion: @escaping(_ boredTask: String) -> Void) {
        netWorkService.getBoredTask { result in
            switch result {
            case .success(let task):
                completion(task.activity)
            case .failure:
                completion("Task")
            }
        }
    }
}
