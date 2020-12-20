//
//  TestViewController.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 20.12.2020.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet var greenView: UIView!
    @IBOutlet var yellowView: UIView!
    
    var landscape: [NSLayoutConstraint]?
    var portrait: [NSLayoutConstraint]?
    var isPortrait: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    func setConstraints() {
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        portrait = [
            yellowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yellowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor)
        ]
        landscape = [
            yellowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yellowView.leftAnchor.constraint(equalTo: view.leftAnchor),
            greenView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greenView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        yellowView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        yellowView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        greenView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
        }
    }

}
