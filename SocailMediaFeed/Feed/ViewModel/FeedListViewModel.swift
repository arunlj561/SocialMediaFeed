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
    var error:Box<Error?> = Box(nil)
    var isLoading:Bool = false
    var hideLoader:Box<Bool?> = Box(nil)
    func fetchFeed(){
        guard !isLoading else{
            return
        }
        isLoading = true
        self.page = UserDefaults.getPageCount()
        ServiceManager.sharedInstance.getUserFeeds(page) { (result) in
            switch result{
            case .failure(let error):
                self.error.value = error
                self.isLoading = false
            case .success(_):
                if self.page == 1{
                    self.hideLoader.value = true
                }
                self.page += 1
                UserDefaults.updatePageCount(self.page)
                self.isLoading = false
            }
        }
    }
        
}
