//
//  TaskTableViewCell.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 10/02/21.
//

import UIKit
// swiftlint:disable line_length

class TaskTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"

    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = UIColor(named: "pendingColor")
        cardView.layer.cornerRadius = 16
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()

    let titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "labelColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .center
        label.textColor = UIColor(named: "labelColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let checkButton: UIButton = {
        let configurationSizeIcon = UIImage.SymbolConfiguration(pointSize: CGFloat(36))
        let configurationWeightIcon = UIImage.SymbolConfiguration(weight: .semibold)
        let configurations = configurationSizeIcon.applying(configurationWeightIcon)
        let configurationNameIcon =  UIImage(systemName: "circle", withConfiguration: configurations)
        let icon = configurationNameIcon?.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)

        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    var check: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.configureLayout()
        self.updateCardLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
    }

    private func setup() {
        self.addSubview(self.cardView)
        self.addSubview(self.checkButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)

        self.selectionStyle = .none
        self.backgroundColor = .clear

        self.contentView.isUserInteractionEnabled = false
        self.checkButton.addTarget(self, action: #selector(checkButtonWasTapped), for: .touchUpInside)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.cardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            self.cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85)
        ])

        NSLayoutConstraint.activate([
            self.checkButton.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor),
            self.checkButton.leftAnchor.constraint(equalTo: self.cardView.leftAnchor, constant: 8),
            self.checkButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            self.checkButton.heightAnchor.constraint(equalTo: self.checkButton.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.checkButton.rightAnchor, constant: 16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.cardView.centerYAnchor),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.cardView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.checkButton.rightAnchor, constant: 16),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.cardView.centerYAnchor),
            self.descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.cardView.trailingAnchor, constant: -16)
        ])
    }

    @objc private func checkButtonWasTapped() {
        self.check = !self.check
        self.updateCardLayout()
    }

    private func updateCardLayout() {
        let color = self.check ? "concludeColor" : "pendingColor"
        let iconName = self.check ? "checkmark.circle" : "circle"

        let configurationSizeIcon = UIImage.SymbolConfiguration(pointSize: CGFloat(36))
        let configurationWeightIcon = UIImage.SymbolConfiguration(weight: .semibold)
        let configurations = configurationSizeIcon.applying(configurationWeightIcon)
        let configurationNameIcon =  UIImage(systemName: iconName, withConfiguration: configurations)
        let icon = configurationNameIcon?.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)

        UIView.animate(withDuration: 0.3, animations: {
            self.checkButton.setImage(icon, for: .normal)
            self.cardView.backgroundColor = UIColor(named: color)
        })
    }

    func configureLabels(_ title: String, _ description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
