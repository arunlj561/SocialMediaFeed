//
//  UserDefaults+Ext.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 04/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
enum DefaultKeys:String {
    case pageCount = "page"
}

extension UserDefaults{
    static func updatePageCount(_ count:Int){
        UserDefaults.standard.set(count, forKey: DefaultKeys.pageCount.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getPageCount() -> Int{
        if let count = UserDefaults.standard.value(forKey: DefaultKeys.pageCount.rawValue) as? Int{
            return count
        }
        return 1
    }
    
}
