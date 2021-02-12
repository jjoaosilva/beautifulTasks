//
//  StatusCard.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 10/02/21.
//

import UIKit

class StatusCard: UIView {

    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "labelColor")

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "labelColor")

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(icon)
        self.addSubview(numberLabel)
        self.addSubview(label)
    }

    private func configureLayout() {
        self.layer.cornerRadius = 16

        NSLayoutConstraint.activate([
            self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.icon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            self.icon.heightAnchor.constraint(equalTo: self.icon.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            self.numberLabel.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 16),
            self.label.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            self.numberLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            self.label.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 16),
            self.label.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            self.label.topAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func configureCard(icon status: TasksStatus) {
        self.icon.image = status.icon
        self.label.text = status.label
        self.backgroundColor = status.backgroundColor
    }

    func setQuantity(with number: Int) {
        self.numberLabel.text = String(number)
    }
}
