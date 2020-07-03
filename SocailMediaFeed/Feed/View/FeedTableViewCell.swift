//
//  FeedTableViewCell.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatar.image = UIImage(named: "placeholder")
        media.image = nil
    }

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var media: UIImageView!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleLink: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    
    func configureViewModel(_ feedViewModel:FeedViewModel){
        userName.text = feedViewModel.userName
        designation.text = feedViewModel.designation
        timestamp.text = feedViewModel.timestamp
        articleContent.text = feedViewModel.articleContent
        articleTitle.text = feedViewModel.articleTitle
        articleLink.attributedText = feedViewModel.articleLink        
        likes.text = feedViewModel.likes
        comments.text = feedViewModel.comments
        userAvatar.image = feedViewModel.avtarImage
        if let mediaImage = feedViewModel.mediaImage{
            media.image = mediaImage
        }
    }
    
}
