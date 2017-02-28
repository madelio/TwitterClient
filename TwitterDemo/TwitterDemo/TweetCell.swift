//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/27/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    

    @IBOutlet weak var retweetButton: UIButton!

    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var retweetCount: Int!
    var favoriteCount: Int!
    
    var thisTweet: Tweet! {
        didSet {
            favoriteCount = thisTweet.favoritesCount
            retweetCount = thisTweet.retweetCount
            
            var timeString = ""
            let user = thisTweet.user
            
            let difference = Int(Date().timeIntervalSince(thisTweet.timeStamp as! Date))
            
            if difference < 60 {
                timeString = "\(difference)s"
            } else if difference < 3600 {
                let time = difference/60
                
                timeString = "\(time)m"
            } else if difference < 86400 {
                let time = difference/3600
                
                timeString = "\(time)h"
            } else {
                let time = difference/86400
                timeString = "\(time)d"
            }
            
            userNameLabel.text = user.name! as String?
            profilePicture.setImageWith(user.profileUrl! as URL)
            tweetLabel.text = thisTweet.text as String?
            twitterHandleLabel.text = "@\(user.screenname!)"
            timeStampLabel.text = timeString
            
            
            if retweetCount > 0 {
                if retweetCount > 1000 {
                    retweetCountLabel.text = String (format: "%.1f", Double(retweetCount)/1000) + "k"
                } else {
                retweetCountLabel.text = String(retweetCount)
                }
            } else {
                retweetCountLabel.text = ""
            }
        
            if favoriteCount > 0 {
                if favoriteCount > 1000 {
                    favoriteCountLabel.text = String (format: "%.1f", Double(favoriteCount)/1000) + "k"
                } else {
                    favoriteCountLabel.text = String(favoriteCount)
                }
            } else {
                favoriteCountLabel.text = ""
            }
            
            
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            replyButton.setImage(UIImage(named:"reply-icon"), for: UIControlState.normal)
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)

            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePicture.layer.cornerRadius = 3
        profilePicture.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoritePressed(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(thisTweet: thisTweet)
        favoriteCount = favoriteCount + 1
        favoriteCountLabel.text = String(favoriteCount)
    }
    @IBAction func retweetPressed(_ sender: Any) {
        
        TwitterClient.sharedInstance?.retweet(thisTweet: thisTweet)
        retweetCount = retweetCount + 1
        retweetCountLabel.text = String(retweetCount)
    }
}
