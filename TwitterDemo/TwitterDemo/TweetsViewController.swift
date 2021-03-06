//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/27/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    var currTweet: Tweet!
    
    
    private var tweetInReplyTo: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // use whatever the constraint rules tell you to do
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // used in conjunction with above code, scroll height dimension
        tableView.estimatedRowHeight = 120
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 49/255, green: 161/255, blue: 240/255, alpha: 0.0)
        //red: 29, green: 202, blue: 255, alpha: 0.0)
    
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TweetCellDelegate
    func tweetCellReplyButtonTappedWithTweetInfo(_ tweetInfo: Tweet) {
        self.tweetInReplyTo = tweetInfo
        self.performSegue(withIdentifier: "replyButtonInCellToTweet", sender: self)
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
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    //    print(tweets[indexPath.row].user.profileUrl!)
        cell.thisTweet = tweets[indexPath.row]
        cell.delegate = self
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using
      /*  let viewController:ViewController = segue!.destinationViewController as ViewController
        let indexPath = self.tableView.indexPathForSelectedRow()
        viewController.pinCode = self.exams[indexPath.row] */
        // Pass the selected object to the new view controller.

        if segue.identifier == "detailsSegue" {
            let detailTweet = sender as! TweetCell
            let detailsVC = segue.destination as! TweetDetailsViewController
            detailsVC.tweet = detailTweet.thisTweet
            //print(detailsVC.favoriteButton?.isSelected)
            print(detailTweet.favoriteButton!.isSelected)
            detailsVC.favorited = detailTweet.favoriteButton!.isSelected
            
            detailsVC.retweeted = detailTweet.retweetButton!.isSelected
           /* detailsVC.tweet.retweetCount = detailTweet.retweetCount
            detailsVC.tweet.favoritesCount = detailTweet.favoriteCount */
 
        
        } else if segue.identifier == "replyButtonInCellToTweet"{
            let msgVC = segue.destination as! ComposeMessageViewController
            msgVC.fromSegue = "toReply"
            msgVC.replyID = self.tweetInReplyTo!.tweetID as? String
            msgVC.replyUser = self.tweetInReplyTo?.user.screenname as? String
        } else {
            let msgVC = segue.destination as! ComposeMessageViewController
            msgVC.fromSegue = "Home"
        
        }
       // let vc =
       // vc.settings =   // ... Search Settings ...
    }
    
}
