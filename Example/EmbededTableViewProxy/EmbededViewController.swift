//
//  EmbededViewController.swift
//  TestDemo
//
//  Created by 王小涛 on 2017/8/4.
//  Copyright © 2017年 王小涛. All rights reserved.
//

import UIKit
import PageViewController

class EmbededViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    let controller1 = EmbededTableViewController()
    let controller2 = EmbededTableViewController()
    
    private lazy var pageViewController: PageViewController = { [unowned self] in
        let pageController = PageViewController(controllers: [self.controller1, self.controller2])
        pageController.didScrollToIndex = {
            self.segmentedControl.selectedSegmentIndex = $0
        }
        return pageController
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.view.frame = containerView.bounds
    }
    
    @IBAction func valueChanged(sender: UISegmentedControl) {
        pageViewController.scrollToIndex(index: sender.selectedSegmentIndex)
    }
}
