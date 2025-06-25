//
//  ViewController.swift
//  task2-4
//
//  Created by georg on 22.05.25.
//

import UIKit

class ViewController: UIViewController {

    private var shapeView: DraggableShapeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        shapeView = DraggableShapeView(frame: .zero)
        shapeView.backgroundColor = .clear
        shapeView.currentBackgroundState = .background1
        shapeView.addGestures(to: shapeView)

        shapeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shapeView)

        NSLayoutConstraint.activate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.widthAnchor.constraint(equalToConstant: 200),
            shapeView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
