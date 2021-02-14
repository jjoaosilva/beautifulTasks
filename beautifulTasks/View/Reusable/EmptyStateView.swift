//
//  EmptyStateView.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 12/02/21.
//

import UIKit

class EmptyStateView: UIView {

    let icon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logoGray")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let title: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sem atividades por aqui =("
        label.textColor = .systemGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.backgroundColor = UIColor(named: "backgroundColor")

        self.addSubview(self.icon)
        self.addSubview(self.title)

        NSLayoutConstraint.activate([
            self.icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            self.title.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 24),
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
