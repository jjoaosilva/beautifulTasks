//
//  BackgroundClocks.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 09/02/21.
//

import UIKit

class BackgroundClocks: UIView {
// swiftlint:disable line_length

    let clocksIcons: [UIImageView] = {
        let numberOfClocks = ClockIconConfiguration.small.quantity + ClockIconConfiguration.medium.quantity + ClockIconConfiguration.large.quantity
        var arrayIcons = [UIImageView]()

        for icon in 0..<numberOfClocks {
            let colorIcon = UIColor(named: "clockIconColor") ?? UIColor.label
            let image = UIImage(systemName: "clock")?.withTintColor(colorIcon, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false

            arrayIcons.append(imageView)
        }
        return arrayIcons
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(named: "backgroundColor")

        for index in 0..<clocksIcons.count {
            let configuration = ClockIconConfiguration.small.configuration[index]

            self.addSubview(self.clocksIcons[index])
            NSLayoutConstraint.activate([
                self.clocksIcons[index].leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * CGFloat(configuration.positionX)),
                self.clocksIcons[index].topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * CGFloat(configuration.positionY)),
                self.clocksIcons[index].widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(configuration.size)),
                self.clocksIcons[index].heightAnchor.constraint(equalTo: self.clocksIcons[index].widthAnchor)
            ])
        }
    }
}
