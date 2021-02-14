//
//  DaysTasksViewController.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 09/02/21.
//

import UIKit
// swiftlint:disable line_length force_cast

class DaysTasksViewController: UIViewController {

    let viewModel: DaysTasksViewModel = DaysTasksViewModel()

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

    let emptyStateView: EmptyStateView = {
        var emptyStateView = EmptyStateView()
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        return emptyStateView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setup()
        self.configureLayout()

        self.viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.statusTasks.consigureQuantities(self.viewModel.concludeTasks, self.viewModel.pendingdTasks)
            }
        }
        self.viewModel.getAllTasksDay()
        self.statusTasks.consigureQuantities(self.viewModel.concludeTasks, self.viewModel.pendingdTasks)
    }

    private func setupNavigationBar() {
        self.title = self.viewModel.date

        let image =  UIImage(systemName: "plus.circle")
        let icon = image?.withTintColor(UIColor(named: "addTaskColor")!, renderingMode: .alwaysOriginal)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.addTaskButtonWasTapped))
    }

    private func setup() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.statusTasks)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.emptyStateView)

        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = true
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

        NSLayoutConstraint.activate([
            self.emptyStateView.topAnchor.constraint(equalTo: self.tableView.topAnchor),
            self.emptyStateView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.emptyStateView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.emptyStateView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func addTaskButtonWasTapped() {
        let createViewModel = CreateTaskViewModel()
        let createTaskController = CreateTaskViewController(viewModel: createViewModel)
        createTaskController.callback = {
            self.viewModel.getAllTasksDay()
            self.viewModel.handleUpdate?()
        }

        let createTasknavigationController = UINavigationController(rootViewController: createTaskController)
        self.navigationController?.present(createTasknavigationController, animated: true, completion: nil)
    }

}

extension DaysTasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Minha atividades"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel.taskList.count

        self.emptyStateView.isHidden = count == 0 ? false : true

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell
        guard let taskCell = cell else {return UITableViewCell()}
        taskCell.configureCell(self.viewModel.taskList[indexPath.row], indexPath.row)
        taskCell.delagate = self.viewModel
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showTaskController = ShowTaskViewController()
        showTaskController.configure(self.viewModel.taskList[indexPath.row])

        self.navigationController?.present(showTaskController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            tableView.beginUpdates()

            if self.viewModel.deleteTask(at: indexPath.row) {
                tableView.deleteRows(at: [indexPath], with: .right)
            }

            tableView.endUpdates()
        }
    }
}
