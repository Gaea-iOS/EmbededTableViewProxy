//
//  FirstViewController.swift
//  TestDemo
//
//  Created by 王小涛 on 2017/8/4.
//  Copyright © 2017年 王小涛. All rights reserved.
//

import UIKit
import EmbededTableViewProxy

class FirstViewController: UITableViewController {
    
    @IBOutlet weak var containerView: UIView!

    let outterScrollProxy = OutterScrollProxy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.showsVerticalScrollIndicator = false
        
        let child = childViewControllers.first as! EmbededViewController
        child.controller1.innerScrollProxy.outterScrollProxy = outterScrollProxy
        child.controller2.innerScrollProxy.outterScrollProxy = outterScrollProxy
        
        outterScrollProxy.innerScrollProxys = [child.controller1.innerScrollProxy, child.controller2.innerScrollProxy]

    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let torance: CGFloat = 44 * 7 - topLayoutGuide.length
        outterScrollProxy.scrollViewDidScroll(scrollView, torance: torance)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return UIScreen.main.bounds.height - bottomLayoutGuide.length - topLayoutGuide.length
        } else {
            return 44
        }
    }

}
