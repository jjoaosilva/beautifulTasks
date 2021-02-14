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
        statusCard.setQuantity(with: 0)
        statusCard.translatesAutoresizingMaskIntoConstraints = false
        return statusCard
    }()

    let pendingCard: StatusCard = {
        let statusCard = StatusCard()
        statusCard.configureCard(icon: TasksStatus.pending)
        statusCard.setQuantity(with: 0)
        statusCard.translatesAutoresizingMaskIntoConstraints = false
        return statusCard
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.backgroundColor = .clear
        self.addSubview(self.pendingCard)
        self.addSubview(self.concludeCard)

        NSLayoutConstraint.activate([
            self.pendingCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.pendingCard.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 8),
            self.pendingCard.heightAnchor.constraint(equalToConstant: 90),
            self.pendingCard.widthAnchor.constraint(equalToConstant: 170)
        ])

        NSLayoutConstraint.activate([
            self.concludeCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.concludeCard.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            self.concludeCard.heightAnchor.constraint(equalToConstant: 90),
            self.concludeCard.widthAnchor.constraint(equalToConstant: 170)
        ])
    }

    func consigureQuantities(_ conclude: Int, _ pending: Int) {
        self.concludeCard.setQuantity(with: conclude)
        self.pendingCard.setQuantity(with: pending)
    }
}
