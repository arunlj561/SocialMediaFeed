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
    var totalFeeds:Box<[Feed]> = Box([])
    var isLoading:Bool = false
    
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
                }else{
                    self.totalFeeds.value.append(contentsOf: feed)
                }
                self.page += 1
                self.totalCount =  self.totalFeeds.value.count
                print(self.totalFeeds.value.count)
            }
        }
    }
    
}
