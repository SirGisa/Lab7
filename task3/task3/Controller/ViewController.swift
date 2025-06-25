//
//  GameViewController.swift
//  task3
//
//  Created by georg on 22.05.25.
//


import UIKit
import MetalKit

class ViewController: UIViewController {
    var metalView: MetalView {
        return view as! MetalView
    }
    
    override func loadView() {
        self.view = MetalView(frame: UIScreen.main.bounds, device: MTLCreateSystemDefaultDevice())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let rotationSpeed: Float = 0.01
        metalView.rotationX += Float(translation.y) * rotationSpeed
        metalView.rotationY += Float(translation.x) * rotationSpeed
        gesture.setTranslation(.zero, in: view)
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        metalView.scale *= Float(gesture.scale)
        gesture.scale = 1.0
    }
}
