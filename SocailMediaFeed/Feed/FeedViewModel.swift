//
//  FeedViewModel.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 03/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class FeedViewModel{
    
    var userAvatar:String?
    var userName: String?
    var designation: String?
    var timestamp: String?
    var mediaUrl: String?
    var articleContent: String?
    var articleTitle: String?
    var articleLink: String?
    var likes: String?
    var comments: String?
    
    init(_ feed:Feed) {
        if let first = feed.user?.first{
            userAvatar = first.avatar
            userName = (first.name ?? "") + " " + (first.lastname ?? "")
            designation = first.designation
        }
        if let media = feed.media?.first{
            mediaUrl = media.image
            articleTitle = media.title
            articleLink = media.url
            
        }
        if let like = feed.likes{
            likes = "Likes \(like.formatUsingAbbrevation())"
        }
        if let comment = feed.comments{
            comments = "Comments \(comment.formatUsingAbbrevation())"
        }

        if let time = feed.createdAt{
            timestamp = time.timeAgoSinceNow()
        }
        
        
        articleContent = feed.content        
    }
}
