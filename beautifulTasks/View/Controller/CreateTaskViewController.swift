//
//  CreateTaskViewController.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 11/02/21.
//

import UIKit
// swiftlint:disable line_length

class CreateTaskViewController: UIViewController {
    var viewModel: CreateTaskViewModel

    public var callback: (() -> Void)?

    let backgroundView: BackgroundClocks = {
        let backgroundView = BackgroundClocks()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    let titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "titleFormColor")
        label.text = "TÍTULO"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleTextField: TextField = {
        let textfield = TextField()
        textfield.backgroundColor = UIColor(named: "backgroundColor")
        textfield.clearButtonMode = .always
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor(named: "titleFormColor")?.cgColor
        textfield.layer.cornerRadius = 8
        textfield.placeholder = "Aqui um titulo"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "titleFormColor")
        label.text = "DESCRIÇÃO"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionTextField: TextField = {
        let textfield = TextField()
        textfield.placeholder = "Ex: marcar como feito após fazer"
        textfield.backgroundColor = UIColor(named: "backgroundColor")
        textfield.clearButtonMode = .always
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor(named: "titleFormColor")?.cgColor
        textfield.layer.cornerRadius = 8
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    init(viewModel: CreateTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.getBoredTask { task in
            DispatchQueue.main.async {
                self.titleTextField.placeholder = task
            }
        }
        self.viewModel.handleDismiss = {
            self.dismiss(animated: true, completion: nil)
            self.callback?()
        }

        self.consigurateNavigationBar()
        self.setup()
        self.consigureLayout()
        self.configureActions()
    }

    private func consigurateNavigationBar() {
        self.title = "Nova task"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    private func setup() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.titleTextField)
        self.view.addSubview(self.descriptionTextField)

        self.titleTextField.becomeFirstResponder()
    }

    private func consigureLayout() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")

        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 24)
        ])

        NSLayoutConstraint.activate([
            self.titleTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.titleTextField.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.titleTextField.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -24),
            self.titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 24)
        ])

        NSLayoutConstraint.activate([
            self.descriptionTextField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 8),
            self.descriptionTextField.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionTextField.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -24),
            self.descriptionTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureActions() {
        self.titleTextField.addTarget(self, action: #selector(self.paintBorder), for: .editingDidBegin)
        self.descriptionTextField.addTarget(self, action: #selector(self.paintBorder), for: .editingDidBegin)

        self.titleTextField.addTarget(self, action: #selector(self.unpaintBorder), for: .editingDidEnd)
        self.descriptionTextField.addTarget(self, action: #selector(self.unpaintBorder), for: .editingDidEnd)
    }

    @objc private func paintBorder(textField: TextField) {
        textField.layer.borderColor = UIColor(named: "concludeColor")?.cgColor
    }

    @objc private func unpaintBorder(textField: TextField) {
        textField.layer.borderColor = UIColor(named: "titleFormColor")?.cgColor
    }

    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func done() {
        self.viewModel.title = self.titleTextField.text!
        self.viewModel.description = self.descriptionTextField.text!
        self.viewModel.save()

    }
}
