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
        
        // use whatever the constraint rules tell you to do
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // used in conjunction with above code, scroll height dimension
        tableView.estimatedRowHeight = 120
        
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
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.thisTweet = tweets[indexPath.row]
        
        
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
