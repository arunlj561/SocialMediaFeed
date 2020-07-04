//
//  Feed.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 03/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

class Feeds:NSManagedObject, Codable{
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case content
        case comments
        case likes
        case media
        case user
    }
    
    @NSManaged var id :String?
    @NSManaged var createdAt:Date?
    @NSManaged var content:String?
    var comments:Int64?
    var likes:Int64?
    @NSManaged var media:Media?
    @NSManaged var user:Users?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Feeds", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.comments = try container.decodeIfPresent(Int64.self, forKey: .comments)
        self.likes = try container.decodeIfPresent(Int64.self, forKey: .likes)
        let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.createdAt = dateFormatter.date(from: dateString ?? "")
        if let media = try container.decodeIfPresent([Media].self, forKey: .media)?.first{
            self.media = media
        }
        if let users = try container.decodeIfPresent([Users].self, forKey: .user)?.first{
            self.user = users
        }
        
        
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(comments, forKey: .comments)
        try container.encode(likes, forKey: .likes)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(media,forKey: .media)
        try container.encode(user,forKey: .user)
    }
}


public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
