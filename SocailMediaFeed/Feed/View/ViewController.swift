//
//  ViewController.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RefreshViews {
    
    let viewModel = FeedListViewModel()
    var avatarDownloaders = Set<ImageDownloader>()
    var mediaDownloaders = Set<ImageDownloader>()
    
    @IBOutlet weak var tableView:UITableView!
    var datasource = FeedDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
    }
    
    func setupTableView(){
        tableView.dataSource = datasource
        datasource.delegate = self
        tableView.delegate = self
        tableView.reloadData()
    }
        
    
    func deleteRows(forindexPath indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func updateRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func insertRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.updateAvatarImage(indexPath)
        self.updateMediaImage(indexPath)
    }
    
    func updateAvatarImage(_ indexPath:IndexPath){
        if let url = datasource.getAvtarImageUrl(indexPath){
            // fetch new image
            if avatarDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first == nil{
                let downloader = ImageDownloader.init(url) { (image) in
                    self.datasource.updateRowAvatar(image, forRow: indexPath)                    
                }
                avatarDownloaders.insert(downloader)
            }
        }
    }
    
    func updateMediaImage(_ indexPath:IndexPath){
        if let url = datasource.getMediaImageUrl(indexPath){
            // fetch new image
            if mediaDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first == nil{
                let downloader = ImageDownloader.init(url) { (image) in
                    self.datasource.updateRowMedia(image, forRow: indexPath)
                }
                mediaDownloaders.insert(downloader)
            }
        }
    }
    
}
