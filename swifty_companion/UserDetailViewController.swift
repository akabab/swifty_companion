//
//  UserDetailViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

  var user: User? = nil

  @IBOutlet weak var profileImage: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let user = user {
//      print(user)

      profileImage.imageFromUrl(user.image_url) // else display default image
    }
  }

  @IBAction func projectButtonPressed() {
    performSegueWithIdentifier("ShowProjects", sender: nil)
  }

  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    return false
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowProjects" {
      if let destinationVC = segue.destinationViewController as? ProjectsTableViewController {
        if let cursus = user?.cursus where cursus.count > 0 {
          destinationVC.projects = cursus[0].projects
        }
      }
    }
  }

}

