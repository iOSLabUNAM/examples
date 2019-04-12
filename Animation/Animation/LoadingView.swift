//
//  LoadingView.swift
//  Animation
//
//  Created by Luis Ezcurdia on 5/18/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    lazy var circle: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: UIColor(named: "violet")!, strokeColor: .clear, radius: 110)
        return layer
    }()

    lazy var strokeLayer: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: .clear, strokeColor: UIColor(named: "purple")!)
        layer.strokeEnd = 0
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi/2.0, 0, 0, 1)
        return layer
    }()

    lazy var pulseLayer: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: UIColor(named: "lavender")!, strokeColor: .clear)
        return layer
    }()

    let pulseAnimation: CAAnimationGroup = {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 2.0

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0

        let pulseAnimation = CAAnimationGroup()
        pulseAnimation.animations = [scaleAnimation, opacityAnimation]
        pulseAnimation.duration = 1
        pulseAnimation.repeatCount = Float.infinity
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return pulseAnimation
    }()

    let progressAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        return animation
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }

    func setupLayers() {
        backgroundColor = UIColor(named: "grape")
        self.layer.addSublayer(pulseLayer)
        self.layer.addSublayer(strokeLayer)
        self.layer.addSublayer(circle)

        pulseLayer.add(pulseAnimation, forKey: "pulseAnimation")
    }

    func animatePulse() {
        strokeLayer.add(progressAnimation, forKey: "progressBarAnimation")
    }

    private func circleShape(at center: CGPoint,
                             fillColor: UIColor,
                             strokeColor: UIColor,
                             radius: CGFloat = 120,
                             strokeWidth: CGFloat = 20) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let circle = UIBezierPath(arcCenter: .zero,
                                  radius: radius,
                                  startAngle: 0,
                                  endAngle: 2*CGFloat.pi,
                                  clockwise: true)
        shape.path = circle.cgPath
        shape.fillColor = fillColor.cgColor
        shape.strokeColor = strokeColor.cgColor
        shape.lineWidth = strokeWidth
        shape.lineCap = CAShapeLayerLineCap.round
        shape.position = center
        return shape
    }
}
