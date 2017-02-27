//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 2/25/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "K67l6ONBMeW9e5krdjvliwK2r", consumerSecret: "o2qEEOzVeCrfCgNXcMbTZ4z3l0qJvZx2is4fRNREPHai9LMqM5")
        
        twitterClient?.deauthorize()
    
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: nil, scope: nil,
                                         success: { (requestToken: BDBOAuth1Credential?) -> Void in
                                            print( "I got a Token" )
                                            
                                            
                                            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                                            
                                            
                                            UIApplication.shared.openURL(url)
        },
                                         failure: { (error: Error?) -> Void in
                                    
                                            print ("error: \(error?.localizedDescription)")
        })
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
