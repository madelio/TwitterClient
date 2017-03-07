//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 3/4/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import AFNetworking


class TweetDetailsViewController: UIViewController {

    
    @IBOutlet weak var screennameLabel: UILabel!
   
    @IBOutlet weak var retweetedByLabel: UILabel!
    @IBOutlet weak var retweetByIcon: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!
    var tweet: Tweet!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!

    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    var favorited: Bool!
    var retweeted: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        usernameLabel.text = tweet.user.name as String?
        screennameLabel.text = "@\(tweet.user.screenname!)"
        textLabel.text = tweet.text as String?
    
        profileImageView.setImageWith(tweet.user.profileUrl as! URL)
        
        
        retweetCountLabel.text = calcRetweets(retweets: tweet.retweetCount)
        favoriteCountLabel.text = calcFavorites(favorites: tweet.favoritesCount)
        dateLabel.text = formatDate(timeStamp: tweet.timeStamp!)
        
        if (tweet.isRetweet) {
            retweetByIcon.image = UIImage(named: "retweet-icon")
            retweetedByLabel.text = "\(tweet.retweetedBy!) retweeted" as String?
            
        } else {
            retweetedByLabel.text = ""
            retweetByIcon.image = nil
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if tweet.retweetStatus {
            self.retweetButton.isSelected = true
        } else {
            retweetButton.isSelected = false
        }
    
        if tweet.favoriteStatus {
            
            favoriteButton.isSelected = true
        } else {
            
            favoriteButton.isSelected = false
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            retweetString = "0"
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
            favoritesString = "0"
        }
        
        return favoritesString
    }
  
    func formatDate(timeStamp: NSDate?) -> String {
       
        // fix date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "M/dd/yy HH:mm a"
        
        let date = dateFormatter.string(from: timeStamp as! Date)
        
        print ("THIS IS THE DATE " + date)
        print ("THIS IS THE TIMESTAMP \(timeStamp!)")
        
        
        return date
    }

    
    @IBAction func faveTweet(_ sender: Any) {
        var favoriteCount = tweet.favoritesCount
        
        if !favoriteButton.isSelected {
            TwitterClient.sharedInstance?.favorite(thisTweet: tweet)
            tweet.favoritesCount = tweet.favoritesCount + 1
            favoriteButton.isSelected = true
            tweet.favoriteStatus = true
            
        } else {
            favoriteButton.isSelected = false
            tweet.favoritesCount = tweet.favoritesCount - 1
            TwitterClient.sharedInstance?.unfavorite(thisTweet: tweet)
            tweet.favoriteStatus = false
            
        }
        favoriteCountLabel.text = calcFavorites(favorites: tweet.favoritesCount)

    }

    @IBAction func retweetTweet(_ sender: Any) {
        
        if !retweetButton.isSelected{
            TwitterClient.sharedInstance?.retweet(thisTweet: tweet)
            tweet.retweetCount = tweet.retweetCount + 1
            retweetButton.isSelected = true
            tweet.retweetStatus = true
            
        } else {
            tweet.retweetCount = tweet.retweetCount - 1
            retweetButton.isSelected = false
            TwitterClient.sharedInstance?.unretweet(thisTweet: tweet)
            tweet.retweetStatus = false
        }
        
        retweetCountLabel.text = calcRetweets(retweets: tweet.retweetCount)
    }
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        print("gesture recognized")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profileSegue" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = self.tweet.user
        } else {
            let mssgVC = segue.destination as! ComposeMessageViewController
            mssgVC.fromSegue = "toReply"
            mssgVC.replyID = self.tweet.tweetID as String?
            mssgVC.replyUser = self.tweet.user.screenname as String?
        }

    }
    

}
