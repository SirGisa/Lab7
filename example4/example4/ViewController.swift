//
//  ViewController.swift
//  example4
//
//  Created by Shvarsman on 9.05.25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureIndicator: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        gestureIndicator.isUserInteractionEnabled = true
        gestureIndicator.textAlignment = .center
        gestureIndicator.numberOfLines = 2
        gestureIndicator.text = "Используйте жесты в этой области"
        gestureIndicator.backgroundColor = .yellow
    }

    @IBAction func tap(sender: AnyObject) {
        gestureIndicator.text = "Жест: касание\nЦвет фона: зелёный"
        gestureIndicator.backgroundColor = .green
    }

    @IBAction func pinch(sender: AnyObject) {
        gestureIndicator.text = "Жест: масштабирование\nЦвет фона: красный"
        gestureIndicator.backgroundColor = .red
    }

    @IBAction func rotation(sender: AnyObject) {
        gestureIndicator.text = "Жест: вращение\nЦвет фона: синий"
        gestureIndicator.backgroundColor = .blue
    }

    @IBAction func swipe(sender: AnyObject) {
        gestureIndicator.text = "Жест: смахивание\nЦвет фона: серый"
        gestureIndicator.backgroundColor = .lightGray
    }

    @IBAction func longPress(sender: AnyObject) {
        gestureIndicator.text = "Жест: долгое нажатие\nЦвет фона: оранжевый"
        gestureIndicator.backgroundColor = .orange
    }
}
