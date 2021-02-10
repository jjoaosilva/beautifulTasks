//
//  TasksStatus.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 10/02/21.
//

import UIKit

enum TasksStatus {
    case conclude
    case pending

    var label: String {
        switch self {
        case .conclude:
            return "Completas"
        case .pending:
            return "Pendentes"
        }
    }

    var icon: UIImage {
        switch self {
        case .conclude:
            let semiBoldConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
            let icon = UIImage(systemName: "checkmark.circle", withConfiguration: semiBoldConfiguration)
            return icon!.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)
        case .pending:
            let semiBoldConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
            let icon = UIImage(systemName: "timer", withConfiguration: semiBoldConfiguration)
            return icon!.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .conclude:
            return UIColor(named: "concludeColor")!
        case .pending:
            return UIColor(named: "pendingColor")!
        }
    }
}
