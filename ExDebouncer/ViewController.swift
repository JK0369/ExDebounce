//
//  ViewController.swift
//  ExDebouncer
//
//  Created by 김종권 on 2024/02/08.
//

import UIKit

class ViewController: UIViewController {
    private let button = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let debouncer = Debouncer(seconds: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap() {
        debouncer.run {
            print("Tap!")
        }
    }
}

class Debouncer {
    private var workItem: DispatchWorkItem?
    private let seconds: Int
    
    init(seconds: Int) {
        self.seconds = seconds
    }
    
    func run(_ closure: @escaping () -> ()) {
        self.workItem?.cancel()
        let newWork = DispatchWorkItem(block: closure)
        workItem = newWork
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds), execute: newWork)
    }
}
