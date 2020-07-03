//
//  FeedDatasource.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class FeedDatasource:NSObject, UITableViewDataSource{
    
    var row :[FeedViewModel] = []
    
    func updateRows(_ feed:[Feed]){
        row = feed.map({ FeedViewModel( $0) })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else{
            return UITableViewCell()
        }
        cell.configureViewModel(row[indexPath.row])        
        return cell
    }
    
    
}
