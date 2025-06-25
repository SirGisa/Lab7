//
//  ViewController.swift
//  task2-2
//
//  Created by georg on 22.05.25.
//

import UIKit

class ViewController: UIViewController {

    var shapeView: UIView!
    var starLayer: AnimatedShapeLayer!
    var rectLayer: AnimatedShapeLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        runAnimations()
    }

    private func setupViews() {
        view.backgroundColor = .white

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)

        starLayer = AnimatedShapeLayer()
        starLayer.path = createStarPath(in: CGRect(x: 50, y: 100, width: 200, height: 200)).cgPath
        starLayer.fillColor = UIColor.yellow.cgColor
        starLayer.position = CGPoint(x: 150, y: 200)
        view.layer.addSublayer(starLayer)

        rectLayer = AnimatedShapeLayer()
        rectLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 140, height: 80),
                                      cornerRadius: ShapeModel.rectCornerRadius).cgPath
        rectLayer.fillColor = UIColor.systemRed.cgColor
        rectLayer.position = CGPoint(x: 150, y: 400)
        rectLayer.opacity = 1.0
        view.layer.addSublayer(rectLayer)
    }

    private func createStarPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        let innerRadius = radius * 0.4

        for i in 0..<8 {
            let angle = CGFloat(i) * .pi / 4
            let r = i % 2 == 0 ? radius : innerRadius
            let x = center.x + cos(angle) * r
            let y = center.y + sin(angle) * r
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        return path
    }

    private func runAnimations() {
        starLayer.animateMove(from: CGPoint(x: 150, y: 200), to: CGPoint(x: 250, y: 300), duration: 3)

        starLayer.animateRotation(duration: 5)

        rectLayer.animateScale(from: 1.0, to: 1.5, duration: 2)

        rectLayer.animateOpacity(from: 1.0, to: 0.4, duration: 2)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.starLayer.animateMoveAndRotate(moveFrom: CGPoint(x: 250, y: 300), moveTo: CGPoint(x: 150, y: 200), rotateDuration: 4)
        }
    }
}

