//
//  FeedListViewModel.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 03/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit


class FeedListViewModel {
    init() {
        fetchFeed()
    }
    
    var page = 1
    var totalCount = 0
    var error:Box<Error?> = Box(nil)
    var isLoading:Bool = false    
    
    func fetchFeed(){
        guard !isLoading else{
            return
        }
        isLoading = true
        self.page = UserDefaults.getPageCount()
        ServiceManager.sharedInstance.getUserFeeds(page) { (result) in
            self.isLoading = false
            switch result{
            case .failure(let error):
                self.error.value = error
            case .success(let feed):
                print(feed)
//                if self.page == 1{
//                    self.delegate?.updateDatasource(feed, shouldAppend: false, insertIndexPath: [])
//                }else{
//                    var indexPath:[IndexPath] = []
//                    for i in (self.totalCount)...((self.totalCount - 1) + pageLimit){
//                        indexPath.append(IndexPath(row: i, section: 0))
//                    }
//                    self.delegate?.updateDatasource(feed, shouldAppend: true, insertIndexPath: indexPath)
//                    self.totalFeeds.value.append(contentsOf: feed)
//                }
                self.page += 1
                UserDefaults.updatePageCount(self.page)
//                self.totalCount =  self.totalFeeds.value.count
            }
        }
    }
        
}
