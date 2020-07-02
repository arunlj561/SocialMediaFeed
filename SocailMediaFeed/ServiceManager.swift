//
//  ServiceManager.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

public enum ServiceResult<T> {
    case failure(Error)
    case success(T)
}


fileprivate enum ServiceParamType{
    case feed(String)
    
    var path:String{
        switch self {
            case .feed: return "v1/blogs"
        }
    }
    var url:URL?{
        switch self {
            case .feed(let base):
            return URL(string: base + self.path)
        }
    }
}

import UIKit
class ServiceManager {
    let baseUrl = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api"
    ///v1/blogs?page=1&limit=10
    static let sharedInstance = ServiceManager()
    
    private init() {
    }
    
    func getUserFeeds(_ completion:@escaping((ServiceResult<[Feed]>) -> Void)){
        let feedParam = ServiceParamType.feed(baseUrl)
        guard let url = feedParam.url else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                return
            }
            do{
                let jsonDecoder = JSONDecoder.init()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let feeds = try jsonDecoder.decode([Feed].self, from: data)
                completion(.success(feeds))
            }catch (let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
