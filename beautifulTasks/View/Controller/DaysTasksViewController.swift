//
//  DaysTasksViewController.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 09/02/21.
//

import UIKit
// swiftlint:disable line_length

class DaysTasksViewController: UIViewController {

    let backgroundView: BackgroundClocks = {
        let backgroundView = BackgroundClocks()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    let statusTasks: StatusTasks = {
        let statusTasks = StatusTasks()
        statusTasks.translatesAutoresizingMaskIntoConstraints = false
        return statusTasks
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setup()
        self.configureLayout()
    }

    private func setupNavigationBar() { // addTaskColor
        self.title = self.getDate()

        let image =  UIImage(systemName: "plus.circle")
        let icon = image?.withTintColor(UIColor(named: "addTaskColor")!, renderingMode: .alwaysOriginal)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.addTaskButtonWasTapped))
    }

    private func setup() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.statusTasks)
        self.view.addSubview(self.tableView)

        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
    }

    private func configureLayout() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")

        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.statusTasks.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.statusTasks.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.statusTasks.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.statusTasks.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15)
        ])

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.statusTasks.bottomAnchor, constant: 24),
            self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func addTaskButtonWasTapped() {
        // up modal
    }

    private func getDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.locale = Locale(identifier: "pt_BR")
        format.setLocalizedDateFormatFromTemplate("EEEEMMMMd")

        let formattedDate = format.string(from: date)
        return formattedDate.capitalized
    }
}

extension DaysTasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Minha atividades"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell
        guard let taskCell = cell else {return UITableViewCell()}
        taskCell.configureLabels("Title Task", "Description Task")
        return taskCell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UITableViewHeaderFooterView()
        titleView.contentView.backgroundColor = UIColor(named: "backgroundSectionColor")

        return titleView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.15
    }
}
