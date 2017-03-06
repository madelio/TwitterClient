//
//  ComposeMessageViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 3/6/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class ComposeMessageViewController: UIViewController {

    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var user = User.currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.setImageWith(user?.profileUrl as! URL)
        usernameLabel.text = user?.name as String?
        screennameLabel.text = user?.screenname as String?
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tweet(_ sender: Any) {
        if messageText.text != "" {
            TwitterClient.sharedInstance?.sendTweet(message: messageText.text)
        }
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    @IBAction func cancelled(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
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
