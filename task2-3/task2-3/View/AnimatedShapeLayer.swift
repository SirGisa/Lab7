//
//  AnimatedShapeLayer.swift
//  task2-3
//
//  Created by georg on 22.05.25.
//


// View/AnimatedShapeLayer.swift

import UIKit

class AnimatedShapeLayer: CAShapeLayer {

    func animateMove(from start: CGPoint, to end: CGPoint, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = start
        animation.toValue = end
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.add(animation, forKey: "move")
    }

    func animateRotation(duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.repeatCount = .infinity
        animation.duration = duration
        self.add(animation, forKey: "rotation")
    }

    func animateScale(from: CGFloat, to: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.add(animation, forKey: "scale")
    }

    func animateOpacity(from: Float, to: Float, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.add(animation, forKey: "opacity")
    }

    func animateMoveAndRotate(moveFrom: CGPoint, moveTo: CGPoint, rotateDuration: CFTimeInterval) {
        animateMove(from: moveFrom, to: moveTo, duration: rotateDuration)
        animateRotation(duration: rotateDuration)
    }
}