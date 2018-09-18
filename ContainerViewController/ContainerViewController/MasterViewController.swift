//
//  ViewController.swift
//  ContainerViewController
//
//  Created by 이광용 on 2018. 6. 27..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var redViewController: UINavigationController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "RedNavigationController") as! UINavigationController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var blueViewController: BlueViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: BlueViewController.reuseIdentifier) as! BlueViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: blueViewController)
            add(asChildViewController: redViewController)
        } else {
            remove(asChildViewController: redViewController)
            add(asChildViewController: blueViewController)
        }
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Actions
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    // MARK: - Helper Methods
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
