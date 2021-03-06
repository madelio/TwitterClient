//
//  User.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/26/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var followersCount: Int = 0
    var followingCount: Int = 0
    var tweetsCount: Int = 0
    var headerUrl: URL?
    static let userDidLogoutNotification = "UserDidLogout"
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        
        tweetsCount = (dictionary["statuses_count"] as? Int) ?? 0
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        let headerUrlString = dictionary["profile_banner_url"] as? String
        if let headerUrlString = headerUrlString {
            headerUrl = URL(string: headerUrlString)
        }
        
        /*else {
            profileUrl = NSURL(string: "https://abs.twimg.com/sticky/default_profile_images/default_profile_3_200x200.png")
        } */

        tagline = dictionary["description"] as? NSString

    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData {
                let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                
                _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
    
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                    defaults.set(data, forKey: "currentUserData")
                
                } else {
                    defaults.removeObject(forKey: "currentUserData")
                }
            
            defaults.synchronize()
        }
    }
}
