//
//  EmbededTableViewController.swift
//  TestDemo
//
//  Created by 王小涛 on 2017/8/4.
//  Copyright © 2017年 王小涛. All rights reserved.
//

import UIKit
import EmbededTableViewProxy

class EmbededTableViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: RecognizeSimultaneousTableView = RecognizeSimultaneousTableView()
    
    let innerScrollProxy = InnerScrollProxy()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        innerScrollProxy.scrollView = tableView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        innerScrollProxy.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}

