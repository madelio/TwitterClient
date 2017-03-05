//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/26/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User
    var tweetID: NSString?
    var retweetStatus: Bool
    var favoriteStatus: Bool
    var isRetweet: Bool
    var retweetedBy: NSString?
    
    init(dictionary: NSDictionary) {
        
        if let origDict = dictionary["retweeted_status"] as? [String: Any] {
            isRetweet = true
            
            let originalTweet = Tweet(dictionary: origDict as NSDictionary)
            //print(dictionary)
            tweetID = originalTweet.tweetID
            text = originalTweet.text
            retweetStatus = originalTweet.retweetStatus
            favoriteStatus = originalTweet.favoriteStatus
            
            retweetCount = originalTweet.retweetCount
            favoritesCount = originalTweet.favoritesCount
            user = originalTweet.user
            
            let retweetedByUser = User(dictionary: dictionary["user"] as! NSDictionary)
            retweetedBy = retweetedByUser.name
            
        } else {
         //   print(dictionary)
            isRetweet = false
            tweetID = dictionary["id_str"] as? NSString
            text = dictionary["text"] as? NSString
            retweetStatus = dictionary["retweeted"] as! Bool
            
            favoriteStatus = dictionary["favorited"] as! Bool
            
            retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
            favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
            let userDictionary = dictionary["user"]
            self.user = User(dictionary: userDictionary as! NSDictionary)
        }

             
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString) as NSDate?
        }
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        
        return tweets
        
    }

}
