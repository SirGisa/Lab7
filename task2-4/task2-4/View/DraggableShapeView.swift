//
//  DraggableShapeView.swift
//  task2-4
//
//  Created by georg on 22.05.25.
//

import UIKit

class DraggableShapeView: ShapeView {

    enum BackgroundState {
        case background1, background2, background3, background4, background5
    }

    var currentBackgroundState: BackgroundState = .background1 {
        didSet {
            updateBackground()
        }
    }

    private func updateBackground() {
        switch currentBackgroundState {
        case .background1:
            currentBackgroundImageName = ShapeModel.backgroundNames[0]
        case .background2:
            currentBackgroundImageName = ShapeModel.backgroundNames[1]
        case .background3:
            currentBackgroundImageName = ShapeModel.backgroundNames[2]
        case .background4:
            currentBackgroundImageName = ShapeModel.backgroundNames[3]
        case .background5:
            currentBackgroundImageName = ShapeModel.backgroundNames[4]
        }
    }

    func addGestures(to view: UIView) {
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))

        view.addGestureRecognizer(rotation)
        view.addGestureRecognizer(pinch)
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(longPress)
        view.addGestureRecognizer(swipe)
    }

    @objc private func handleRotation(_ sender: UIRotationGestureRecognizer) {
        currentBackgroundState = .background1
    }

    @objc private func handlePinch(_ sender: UIPinchGestureRecognizer) {
        currentBackgroundState = .background2
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        currentBackgroundState = .background3
    }

    @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        currentBackgroundState = .background4
    }

    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        currentBackgroundState = .background5
    }
}
