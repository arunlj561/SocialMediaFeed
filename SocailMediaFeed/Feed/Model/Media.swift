//
//  Media.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 04/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

class Media:NSManagedObject, Codable{
    enum CodingKeys: String, CodingKey {
        case id
        case blogId
        case createdAt
        case image
        case title
        case url
    }
    
        @NSManaged var id:String?
        @NSManaged var blogId:String?
        @NSManaged var createdAt:Date?
        @NSManaged var image:String?
        @NSManaged var title:String?
        @NSManaged var url:String?

    
    
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Media", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.blogId = try container.decodeIfPresent(String.self, forKey: .blogId)
        let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.createdAt = dateFormatter.date(from: dateString ?? "")
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(blogId, forKey: .blogId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(image, forKey: .image)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
    }
}
