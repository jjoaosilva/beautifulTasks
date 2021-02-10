//
//  ClockConfiguration.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 09/02/21.
//

import Foundation
// swiftlint:disable line_length large_tuple

enum ClockIconConfiguration {
    case small
    case medium
    case large

    var quantity: Int {
        switch self {
        case .small:
            return 2
        case .medium:
            return 2
        case .large:
            return 3
        }
    }

    var configuration: [(size: Float, positionX: Float, positionY: Float)] {
        return [(size: 0.17, positionX: 0.1, positionY: 0.3), (size: 0.17, positionX: 0.75, positionY: 0.6),
                (size: 0.24, positionX: 0.65, positionY: 0.25), (size: 0.24, positionX: 0.2, positionY: 0.75),
                (size: 0.24, positionX: 0, positionY: 0), (size: 0.4, positionX: 0.25, positionY: 0.35), (size: 0.24, positionX: 0.7, positionY: 0.78)]
    }
}
