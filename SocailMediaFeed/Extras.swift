//
//  Extras.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

let pageLimit = 10


func getQueryParams(_ param:[String:Any?]) -> [URLQueryItem]?{
    return param.map { (key: String, value: Any?) -> URLQueryItem in
        if let value = value {
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
        return URLQueryItem(name: "", value: "")
    }
}

