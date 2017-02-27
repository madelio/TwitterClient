//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/27/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
     
       
        
        TwitterClient.sharedInstance?.homeTimeLine(success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            /*for tweet in tweets {
                print(tweet.text)
            } */
            
        }, failure: { (error: Error) -> () in
            
            print(error.localizedDescription)
            
        })

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var timeString = ""
        let tweet = tweets[indexPath.row]
        let user = tweet.user
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let difference = Int(Date().timeIntervalSince(tweets[indexPath.row].timeStamp as! Date))
        
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
        
        cell.userNameLabel.text = user.name! as String?
        cell.profilePicture.setImageWith(user.profileUrl! as URL)
        cell.tweetLabel.text = tweet.text as String?
        cell.twitterHandleLabel.text = "@\(user.screenname!)"
        cell.retweetIcon.image = UIImage(named: "retweet-icon")
        cell.replyIcon.image = UIImage(named: "reply-icon")
        cell.favoriteIcon.image = UIImage(named: "favor-icon")
        
        cell.timeStampLabel.text = timeString
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
