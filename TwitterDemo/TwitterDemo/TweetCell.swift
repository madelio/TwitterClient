//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/27/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var thisTweet: Tweet!
    
    @IBOutlet weak var retweetButton: UIButton!

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var retweetedUser: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var retweetedByIcon: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
        replyButton.setImage(UIImage(named:"reply-icon"), for: UIControlState.normal)
        
        favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
        
        profilePicture.layer.cornerRadius = 3
        profilePicture.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweetPressed(_ sender: Any) {
        let tweetID = thisTweet.ID
        
        TwitterClient.sharedInstance?.retweet(success: {(tweetID) -> () in
            print("retweet pressed")
            
        }, failure: { (error: Error) -> () in
            
            print(error.localizedDescription)
        
        })
        
    }
}
