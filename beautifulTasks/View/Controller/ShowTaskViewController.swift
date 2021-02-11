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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configureLayout()
        // Do any additional setup after loading the view.
    }

    private func setup() {
        self.view.addSubview(backgroundView)
    }

    private func configureLayout() {
        self.view.backgroundColor = .none
        self.backgroundView.layer.cornerRadius = 24
        NSLayoutConstraint.activate([
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backgroundView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
    }

    func configure(_ status: Bool) {
        let colorName = status ? "concludeColor": "pendingColor"

        self.backgroundView.backgroundColor = UIColor(named: colorName)
    }
}
