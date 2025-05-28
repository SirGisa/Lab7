//
//  ViewController.swift
//  task2-2
//
//  Created by Shvarsman on 10.05.25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let shapeView = ShapeView(frame: view.bounds)
        shapeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(shapeView)
    }
}

