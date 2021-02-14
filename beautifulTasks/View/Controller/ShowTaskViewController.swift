//
//  ShowTaskViewController.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 11/02/21.
//

import UIKit

class ShowTaskViewController: UIViewController {

    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        label.textColor = UIColor(named: "labelColor")
        label.text = "Title Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "labelColor")
        label.text = "Description Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let backgroundButton: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 16
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    let iconButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleButton: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "labelColor")
        label.text = "Title Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let closeButton: UIButton = {
        let configurationSizeIcon = UIImage.SymbolConfiguration(pointSize: CGFloat(36))
        let configurationWeightIcon = UIImage.SymbolConfiguration(weight: .semibold)
        let configurations = configurationSizeIcon.applying(configurationWeightIcon)
        let configurationNameIcon =  UIImage(systemName: "xmark.circle", withConfiguration: configurations)
        let icon = configurationNameIcon?.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)

        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configureLayout()
    }

    private func setup() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.backgroundButton)
        self.view.addSubview(self.titleButton)
        self.view.addSubview(self.iconButton)
        self.view.addSubview(self.closeButton)

        self.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)

    }

    private func configureLayout() {
        self.view.backgroundColor = .clear
        self.backgroundView.layer.cornerRadius = 24

        NSLayoutConstraint.activate([
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backgroundView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 70),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.backgroundButton.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.backgroundButton.widthAnchor.constraint(equalToConstant: 170),
            self.backgroundButton.heightAnchor.constraint(equalToConstant: 105),
            self.backgroundButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            self.iconButton.topAnchor.constraint(equalTo: self.backgroundButton.topAnchor, constant: 8),
            self.iconButton.centerXAnchor.constraint(equalTo: self.backgroundButton.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.titleButton.topAnchor.constraint(equalTo: self.iconButton.bottomAnchor, constant: 8),
            self.titleButton.centerXAnchor.constraint(equalTo: self.backgroundButton.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.closeButton.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 16),
            self.closeButton.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -16)
        ])
    }

    @objc private func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }

    func configure(_ task: TaskDTO) {
        let colorName = task.done ? "concludeColor": "pendingColor"
        let iconName = task.done ? "checkmark.circle" : "deskclock"
        let titleButton = task.done ? "Resolvido" : "Resolver"
        let colorNameButton = task.done ? "modalConcludeButtonColor" : "modalPendingButtonColor"

        self.backgroundView.backgroundColor = UIColor(named: colorName)

        let configurationSizeIcon = UIImage.SymbolConfiguration(pointSize: CGFloat(48))
        let configurationWeightIcon = UIImage.SymbolConfiguration(weight: .semibold)
        let configurations = configurationSizeIcon.applying(configurationWeightIcon)
        let configurationNameIcon =  UIImage(systemName: iconName, withConfiguration: configurations)
        let icon = configurationNameIcon?.withTintColor(UIColor(named: "labelColor")!, renderingMode: .alwaysOriginal)

        self.iconButton.image = icon
        self.titleButton.text = titleButton

        self.backgroundButton.backgroundColor = UIColor(named: colorNameButton)

        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.subtitle
    }
}
