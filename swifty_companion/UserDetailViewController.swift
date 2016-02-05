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
  @IBOutlet weak var phoneButton: UIButton!
  @IBOutlet weak var emailButton: UIButton!
  @IBOutlet weak var locationLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let user = user {
//      print(user)

      profileImage.imageFromUrl(user.image_url, contentMode: .ScaleAspectFill)
      nameLabel.text = user.name
      loginLabel.text = user.login
      phoneButton.setTitle(user.phone, forState: .Normal)
      emailButton.setTitle(user.email, forState: .Normal)
      locationLabel.text = user.location
    }
    
    self.profileImage.layer.cornerRadius = 50
    self.profileImage.clipsToBounds = true
    tableView.tableFooterView = UIView()
  }

  @IBAction func phoneButtonPressed() {
    if let phoneNumber = phoneButton.currentTitle?.removeWhitespace() {
      promptPhoneNumber(phoneNumber)
    }
  }

  @IBAction func emailButtonPressed() {
    if let to = emailButton.currentTitle?.removeWhitespace() {
      mailTo(to)
    }
  }

  private func mailTo(to: String) {
    if let url = NSURL(string: "mailto://\(to)") {
      UIApplication.sharedApplication().openURL(url)
    }
    else {
      print("Invalid format for email: \(to)")
    }
  }

  private func callPhoneNumber(phoneNumber: String) {
    if let url = NSURL(string: "tel://\(phoneNumber)") {
      UIApplication.sharedApplication().openURL(url)
    }
    else {
      print("Invalid format for phone number: \(phoneNumber)")
    }
  }

  private func promptPhoneNumber(phoneNumber: String) {
    if let url = NSURL(string: "telprompt://\(phoneNumber)") {
      UIApplication.sharedApplication().openURL(url)
    }
    else {
      print("Invalid format for phone number: \(phoneNumber)")
    }
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

