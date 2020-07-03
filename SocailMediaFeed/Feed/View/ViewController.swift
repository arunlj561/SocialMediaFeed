//
//  ViewController.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UpdateFeeds {
    
    
    
    let viewModel = FeedListViewModel()
    var avatarDownloaders = Set<ImageDownloader>()
    var mediaDownloaders = Set<ImageDownloader>()
    
    @IBOutlet weak var tableView:UITableView!
    var datasource = FeedDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.setupTableView()
        
    }
    
    func setupTableView(){
        tableView.dataSource = datasource        
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func updateDatasource(_ feed: [Feed], shouldAppend: Bool, insertIndexPath: [IndexPath]) {
        self.datasource.updateRows(feed, shouldAppend: shouldAppend)
        if insertIndexPath.count > 0{
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertIndexPath, with: .bottom)
                self.tableView.endUpdates()
            }
        }else{
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.updateAvatarImage(indexPath)
        self.updateMediaImage(indexPath)
    }
    
    func updateAvatarImage(_ indexPath:IndexPath){
        if let url = viewModel.getAvtarImageUrl(indexPath){
            // fetch new image
            if avatarDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first == nil{
                let downloader = ImageDownloader.init(url) { (image) in
                    if self.datasource.updateRowAvatar(image, forRow: indexPath.row){
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
                avatarDownloaders.insert(downloader)
            }
        }
    }
    
    func updateMediaImage(_ indexPath:IndexPath){
        if let url = viewModel.getMediaImageUrl(indexPath){
            // fetch new image
            if mediaDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first == nil{
                let downloader = ImageDownloader.init(url) { (image) in
                    if self.datasource.updateRowMedia(image, forRow: indexPath.row){
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
                mediaDownloaders.insert(downloader)
            }
        }
    }
    
}
