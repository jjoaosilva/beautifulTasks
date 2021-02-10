//
//  StatusTasks.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 10/02/21.
//

import UIKit

class StatusTasks: UIView {

    let concludeCard: StatusCard = {
        let statusCard = StatusCard()
        statusCard.configureCard(icon: TasksStatus.conclude)
        //Mock
        statusCard.setQuantity(with: 10)
        statusCard.translatesAutoresizingMaskIntoConstraints = false
        return statusCard
    }()

    let pendingCard: StatusCard = {
        let statusCard = StatusCard()
        statusCard.configureCard(icon: TasksStatus.pending)
        //Mock
        statusCard.setQuantity(with: 10)
        statusCard.translatesAutoresizingMaskIntoConstraints = false
        return statusCard
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.backgroundColor = .clear

        let stack = UIStackView(arrangedSubviews: [self.concludeCard, self.pendingCard])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.setCustomSpacing(16, after: self.concludeCard)
        stack.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}
