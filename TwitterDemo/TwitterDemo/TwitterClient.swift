//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/26/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "K67l6ONBMeW9e5krdjvliwK2r", consumerSecret: "o2qEEOzVeCrfCgNXcMbTZ4z3l0qJvZx2is4fRNREPHai9LMqM5")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    
    func currentAccount(success: @escaping (User)-> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
        
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            self.currentAccount(success: {(user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: {(error: Error) ->() in
                self.loginFailure?(error)
                
            })
        }, failure: {(error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })

        
    }
    
    func login(success:@escaping () -> () ,failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil,
                                         success: { (requestToken: BDBOAuth1Credential?) -> Void in
                                        
                                            
                                            
                                            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                                            
                                            
                                            UIApplication.shared.openURL(url as URL)
        },
                                         failure: { (error: Error?) -> Void in
                                            
                                            print ("error: \(error?.localizedDescription)")
                                            self.loginFailure?(error!)
        })

    }
    
    func retweet(success: (String) -> (), failure: (Error) -> ()) {
        get("1.1/statuses/retweet/243149503589400576.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            
            
            
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            
        })
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
       
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }

}
