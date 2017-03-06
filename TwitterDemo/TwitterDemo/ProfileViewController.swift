//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Madel Asistio on 3/6/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var headerImageView: UIImageView!

    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var user: User!
  
    @IBOutlet weak var tweetCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let composeMssgBtn = UIButton(type: .custom)
        
        composeMssgBtn.setImage(UIImage(named: "edit-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        composeMssgBtn.tintColor = .white
        composeMssgBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        composeMssgBtn.addTarget(self, action: "tweetTo", for: .touchUpInside)
    
        let msgBarBtn = UIBarButtonItem(customView: composeMssgBtn)
        
        self.navigationItem.setRightBarButton(msgBarBtn, animated: true)
        
        nameLabel.text = user.name as String?
        
        screennameLabel.text = "@\(user.screenname!)"
        
        if user.headerUrl != nil {
            headerImageView.setImageWith(user.headerUrl!)
        } else {
            headerImageView.backgroundColor = UIColor.blue
        }
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        profileImage.setImageWith(user.profileUrl! as URL)

        followerCountLabel.text = String(user.followersCount)
        followingCountLabel.text = String(user.followingCount
        )
        tweetCountLabel.text = String(user.tweetsCount)

        // Do any additional setup after loading the view.
    }
    
    func tweetTo() {
        self.performSegue(withIdentifier: "tweetAt", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mssgVC = segue.destination as! ComposeMessageViewController
        mssgVC.fromSegue = "@\(user.screenname!) "
    }
    

}
