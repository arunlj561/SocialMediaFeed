//
//  ViewController.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = FeedListViewModel()
    
    @IBOutlet weak var tableView:UITableView!
    var datasource = FeedDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.bindUI()
    }
    
    func setupTableView(){
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func bindUI() {
        viewModel.totalFeeds.bindHandler { [unowned self](feeds) in
            self.datasource.updateRows(feeds)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController:UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            viewModel.fetchFeed()
        }
    }
}

extension ViewController:UITableViewDelegate{
    
}
