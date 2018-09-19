//
//  ViewController.swift
//  TestHeader
//
//  Created by Max Bolotov on 9/19/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var headerView: UIView!
    
    let headerHeight: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.headerView = tableView.tableHeaderView
        self.tableView?.tableHeaderView = nil
        
        if let header = self.headerView {
            self.tableView?.addSubview(header)
        }
        
        self.tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -headerHeight)
    }
    
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -headerHeight, width: tableView.bounds.width, height: headerHeight)
        
        if tableView.contentOffset.y < -headerHeight {
            
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeaderView()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Testtovich"
        return cell
    }
}

