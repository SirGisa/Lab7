//
//  ShapeView.swift
//  task2-2
//
//  Created by georg on 22.05.25.
//

import UIKit

class ShapeView: UIView {

    var currentBackgroundImageName: String? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let starPath = createStarPath(in: bounds.insetBy(dx: 20, dy: 20))

        context.saveGState()

        starPath.addClip()

        if let imageName = currentBackgroundImageName,
           let image = UIImage(named: imageName) {
            image.draw(in: bounds)
        } else {
            UIColor.white.setFill()
            starPath.fill()
        }

        context.restoreGState()

        starPath.lineWidth = 3
        UIColor.black.setStroke()
        starPath.stroke()
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
}
