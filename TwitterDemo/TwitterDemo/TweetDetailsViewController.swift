//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 3/4/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if (indexPath.row == 0) {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
            //    print(tweets[indexPath.row].user.profileUrl!)
         //   cell.thisTweet = tweets[indexPath.row]
            
            return cell
            
        }
        
        /*else if (indexPath.row == 1 ){
            
        } else {
            
        } */
        
        return cell
        
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
