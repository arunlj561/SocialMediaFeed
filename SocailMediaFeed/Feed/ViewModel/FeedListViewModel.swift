//
//  FeedListViewModel.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 03/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

protocol UpdateFeeds:class {
    func updateDatasource(_ feed:[Feeds], shouldAppend:Bool, insertIndexPath:[IndexPath])
}

class FeedListViewModel {
    init() {
        fetchFeed()
    }
    
    var page = 1
    var totalCount = 0
    var totalFeeds:Box<[Feeds]> = Box([])
    var isLoading:Bool = false
    weak var delegate:UpdateFeeds?
    
    func fetchFeed(){
        guard !isLoading else{
            return
        }
        isLoading = true
        ServiceManager.sharedInstance.getUserFeeds(page) { (result) in
            self.isLoading = false
            switch result{
            case .failure(let error):
                
                print(error)
            case .success(let feed):
                
                if self.page == 1{
                    self.totalFeeds.value = feed
                    self.delegate?.updateDatasource(feed, shouldAppend: false, insertIndexPath: [])
                }else{
                    var indexPath:[IndexPath] = []
                    for i in (self.totalCount)...((self.totalCount - 1) + pageLimit){
                        indexPath.append(IndexPath(row: i, section: 0))
                    }
                    self.delegate?.updateDatasource(feed, shouldAppend: true, insertIndexPath: indexPath)
                    self.totalFeeds.value.append(contentsOf: feed)
                }
                self.page += 1
                self.totalCount =  self.totalFeeds.value.count
            }
        }
    }
    
    func getAvtarImageUrl(_ indexPath:IndexPath) -> URL?{
        let feed = totalFeeds.value[indexPath.row]
        if let url = URL(string: FeedViewModel.init(feed).userAvatar ?? ""){
            return url
        }
        return nil
    }
    func getMediaImageUrl(_ indexPath:IndexPath) -> URL?{
        let feed = totalFeeds.value[indexPath.row]
        if let url = URL(string: FeedViewModel.init(feed).mediaUrl ?? ""){
            return url
        }
        return nil
        
    }
}
