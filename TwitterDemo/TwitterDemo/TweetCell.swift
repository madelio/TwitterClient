//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/27/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    

   
    @IBOutlet weak var retweetedBy: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetedByIcon: UIImageView!

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
            
            if (thisTweet.isRetweet) {
                 retweetedByIcon.image = UIImage(named: "retweet-icon")
                retweetedBy.text = "\(thisTweet.retweetedBy!) retweeted" as String?
                
            } else {
                retweetedBy.text = ""
                retweetedByIcon.image = nil
            }
            
            userNameLabel.text = user.name! as String?
            profilePicture.setImageWith(user.profileUrl! as URL)
            tweetLabel.text = thisTweet.text as String?
            twitterHandleLabel.text = "@\(user.screenname!)"
            timeStampLabel.text = timeString
            
            
            retweetCountLabel.text = calcRetweets(retweets: retweetCount)
            favoriteCountLabel.text = calcFavorites(favorites: favoriteCount)
        
            
            if thisTweet.retweetStatus {
                retweetButton.isSelected = true
            } else {
                retweetButton.isSelected = false
                retweetCountLabel.textColor = UIColor.gray
            }

            if thisTweet.favoriteStatus {
                //favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
                favoriteButton.isSelected = true
            } else {
               // favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
                favoriteButton.isSelected = false
                    favoriteCountLabel.textColor = UIColor.gray
            }
            
            replyButton.setImage(UIImage(named:"reply-icon"), for: UIControlState.normal)
         

            
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
        if !favoriteButton.isSelected {
            TwitterClient.sharedInstance?.favorite(thisTweet: thisTweet)
            favoriteCount = favoriteCount + 1
            favoriteButton.isSelected = true
            
        } else {
            favoriteButton.isSelected = false
            favoriteCount = favoriteCount - 1
            TwitterClient.sharedInstance?.unfavorite(thisTweet: thisTweet)
            
        }
         favoriteCountLabel.text = calcFavorites(favorites: favoriteCount)
    }
    @IBAction func retweetPressed(_ sender: Any) {
        
        if !retweetButton.isSelected{
            TwitterClient.sharedInstance?.retweet(thisTweet: thisTweet)
            retweetCount = retweetCount + 1
            retweetButton.isSelected = true
            
        } else {
            retweetCount = retweetCount - 1
            retweetButton.isSelected = false
            TwitterClient.sharedInstance?.unretweet(thisTweet: thisTweet)
            
        }
        
        retweetCountLabel.text = calcRetweets(retweets: retweetCount)
    }
    
    func calcRetweets(retweets: Int) -> String {
        var retweetString = ""
        
        if retweets > 0 {
            if retweets > 1000 {
                retweetString = String (format: "%.1f", Double(retweets)/1000) + "k"
            } else {
                retweetString = String(retweets)
            }
        } else {
            retweetString = ""
        }
        
        return retweetString
    }
    
    func calcFavorites(favorites: Int) -> String {
        var favoritesString = ""
        if favorites > 0 {
            if favorites > 1000 {
                favoritesString = String (format: "%.1f", Double(favorites)/1000) + "k"
            } else {
                favoritesString = String(favorites)
            }
        } else {
            favoritesString = ""
        }
        
        return favoritesString
    }
}
