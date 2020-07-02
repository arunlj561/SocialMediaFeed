//
//  FeedDatasource.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class FeedDatasource:NSObject, UITableViewDataSource{
    
    var row :[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
extension UITableViewCell{
    static var reuseIdentifier:String{
        return "\(self)"
    }
}
