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
            case .feed: return "v1/blogs?page=1&limit=10"
        }
    }
    var fullPath:String{
        switch self {
            case .feed(let base):
            return base + self.path
        }
    }
    
    func getParam(_ pageNo:Int) -> [String:Any]? {
        switch self {
        case .feed(_):
            return ["page":pageNo,"limit":pageLimit]
        }
    }
    
    func getUrl(_ pageNo:Int) -> URL?{
        switch self {
        case .feed(_):
            var urlComponents = URLComponents(string: fullPath)
            if let param = getParam(pageNo) {
                urlComponents?.queryItems = getQueryParams(param)
            }
            return urlComponents?.url
        }
    }
    
}

import UIKit
class ServiceManager {
    let baseUrl = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/"
    static let sharedInstance = ServiceManager()
    
    private init() {
    }
    
    func getUserFeeds(_ pageNo:Int, completion:@escaping((ServiceResult<[Feeds]>) -> Void)){
        let feedParam = ServiceParamType.feed(baseUrl)
        guard let url = feedParam.getUrl(pageNo) else {
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

                /*
                let jsonDecoder = JSONDecoder.init()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let feeds = try jsonDecoder.decode([Feed].self, from: data)
                completion(.success(feeds))
                */
                
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve managed object context")
                }
                
                // Parse JSON data
                let managedObjectContext = CoreDataManager.persistentContainer.viewContext
                let decoder = JSONDecoder()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                let feeds = try decoder.decode([Feeds].self, from: data)
                try managedObjectContext.save()
                
                completion(.success(feeds))
            }catch (let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
}
