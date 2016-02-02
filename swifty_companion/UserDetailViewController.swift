//
//  UserDetailViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

class UserDetailTableViewController: UITableViewController {

  var user: User? = nil

  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var loginLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let user = user {
//      print(user)

      profileImage.imageFromUrl(user.image_url) // else display default image
      nameLabel.text = user.name
      loginLabel.text = user.login
    }
    
    self.profileImage.layer.cornerRadius = 50
    self.profileImage.clipsToBounds = true
    tableView.tableFooterView = UIView()
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

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

}

