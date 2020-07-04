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
    var articleContent: String?
    var articleTitle: String?
    var articleLink: NSAttributedString?
    var likes: String?
    var comments: String?
    var mediaUrl: String?
    var mediaImage:UIImage?
    var avtarImage:UIImage? = UIImage(named: "placeholder")
    
    init(_ feed:Feeds) {
        if let first = feed.user{
            userAvatar = first.avatar
            userName = (first.name ?? "") + " " + (first.lastname ?? "")
            designation = first.designation
        }
        if let media = feed.media{
            mediaUrl = media.image
            articleTitle = media.title
            
            if let link = media.url{
                let attributedString = NSMutableAttributedString(string: link)
                attributedString.addAttribute(.link, value: link, range: NSRange(location: 0, length: link.count))
                articleLink =  attributedString
            }            
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
    
    func updateAvatarImage(_ image:UIImage?){
        self.avtarImage = image
    }
    
    func updateMediaImage(_ image:UIImage?){
        self.mediaImage = image
    }
}
