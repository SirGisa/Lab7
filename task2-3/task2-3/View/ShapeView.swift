//
//  ShapeView.swift
//  task2-2
//
//  Created by georg on 22.05.25.
//


// View/ShapeView.swift

import UIKit

class ShapeView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()!
        let colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)!
        context.drawLinearGradient(gradient,
                                   start: .zero,
                                   end: CGPoint(x: 0, y: bounds.height),
                                   options: [])

        drawStar(in: CGRect(x: 50, y: 100, width: 200, height: 200), color: .yellow, context: context)

        drawRectangle(in: CGRect(x: 80, y: 350, width: 140, height: 80), color: .systemRed)
    }

    private func drawStar(in rect: CGRect, color: UIColor, context: CGContext) {
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

        let circle = UIBezierPath(ovalIn: rect)
        path.append(circle)
        path.usesEvenOddFillRule = true

        color.setFill()
        path.fill()
        
        context.setShadow(offset: CGSize(width: 5, height: 5), blur: 10, color: UIColor.black.cgColor)
        path.stroke()
    }

    private func drawRectangle(in rect: CGRect, color: UIColor) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: ShapeModel.rectCornerRadius)
        color.setFill()
        path.fill()

        let context = UIGraphicsGetCurrentContext()!
        context.setShadow(offset: CGSize(width: 3, height: 3), blur: 5, color: UIColor.black.cgColor)
        path.stroke()
    }
}
