//
//  ClocksView.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 09/02/21.
//

import UIKit
// swiftlint:disable line_length

class ClocksView: UIView {

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

    lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        return animator
    }()

    var attach: UIDynamicItemBehavior?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureCollisionBehavior()
        self.configureVortexBehavior()
        self.configureNoiseBehavior()
        self.attachClocks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        self.backgroundColor = UIColor(named: "backgroundColor")

        for index in 0..<clocksIcons.count {
            let configuration = ClockIconConfiguration.small.configuration[index]

            self.addSubview(self.clocksIcons[index])
            NSLayoutConstraint.activate([
                self.clocksIcons[index].leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.bounds.width * CGFloat(configuration.positionX)),
                self.clocksIcons[index].topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * CGFloat(configuration.positionY)),
                self.clocksIcons[index].widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(configuration.size)),
                self.clocksIcons[index].heightAnchor.constraint(equalTo: self.clocksIcons[index].widthAnchor)
            ])
        }
    }

    func attachClocks() {
        self.attach = UIDynamicItemBehavior(items: self.clocksIcons)
        self.attach!.isAnchored = true
        self.animator.addBehavior(attach!)
    }

    func unhookCloks() {
        self.animator.removeBehavior(self.attach!)
        self.attach!.isAnchored = false
        self.animator.addBehavior(attach!)
    }

    private func configureVortexBehavior() {
        let vortexField = UIFieldBehavior.vortexField()
        vortexField.strength = 1.5
        vortexField.position = self.center
        vortexField.region = UIRegion(radius: 800)

        self.clocksIcons.forEach { icon in
            vortexField.addItem(icon)
        }
        self.animator.addBehavior(vortexField)
    }

    private func configureCollisionBehavior() {
        let collision = UICollisionBehavior(items: self.clocksIcons)
        collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(collision)
    }

    private func configureNoiseBehavior() {
        let noiseField = UIFieldBehavior.noiseField(smoothness: 2, animationSpeed: 2)
        noiseField.strength = 10
        noiseField.position = self.center
        noiseField.region = UIRegion(radius: 800)

        self.clocksIcons.forEach { icon in
            noiseField.addItem(icon)
        }
        self.animator.addBehavior(noiseField)
    }

}
