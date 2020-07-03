//
//  Box.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 03/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
class Box<T>{
    
    var listener:((T) -> ())?
    
    init(_ val:T) {
        self.value = val
    }
    
    var value:T{
        didSet{
            self.listener?(value)
        }
    }
    
    func bindHandler(_ bind:@escaping ((T) -> ())){
        self.listener = bind
    }
    
}
