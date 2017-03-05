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
    @IBOutlet weak var profileImageButton: UIButton!
    var tweet: Tweet!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!

    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = tweet.user.name as String?
        screennameLabel.text = "@\(tweet.user.screenname!)"
        textLabel.text = tweet.text as String?
    
        profileImageButton.setImageFor(UIControlState.normal
            , with: tweet.user.profileUrl as! URL)
        
        profileImageButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        retweetCountLabel.text = calcRetweets(retweets: tweet.retweetCount)
        favoriteCountLabel.text = calcFavorites(favorites: tweet.favoritesCount)
        
        if (tweet.isRetweet) {
            retweetByIcon.image = UIImage(named: "retweet-icon")
            retweetedByLabel.text = "\(tweet.retweetedBy!) retweeted" as String?
            
        } else {
            retweetedByLabel.text = ""
            retweetByIcon.image = nil
        }

       
        dateLabel.text = formatDate(timeStamp: tweet.timeStamp!)


        // Do any additional setup after loading the view.
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
  
    func formatDate(timeStamp: NSDate?) -> String {
       
        // fix date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "M/dd/yy HH:mm a"
        
        let date = dateFormatter.string(from: timeStamp as! Date)
        
        print ("THIS IS THE DATE " + date)
        print ("THIS IS THE TIMESTAMP \(timeStamp!)")
        
        
        return date
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
