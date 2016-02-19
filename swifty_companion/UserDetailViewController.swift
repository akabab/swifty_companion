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

  @IBOutlet weak var titleItem: UINavigationItem!

  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var loginLabel: UILabel!
  @IBOutlet weak var phoneButton: UIButton!
  @IBOutlet weak var emailButton: UIButton!
  @IBOutlet weak var locationLabel: UILabel!

  @IBOutlet weak var crownImage: UIImageView!

  @IBOutlet weak var projectsCell: UITableViewCell!
  @IBOutlet weak var achievementsCell: UITableViewCell!
  @IBOutlet weak var skillsCell: UITableViewCell!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let user = user {

      profileImage.imageFromUrl(user.image_url, contentMode: .ScaleAspectFill)
      nameLabel.text = user.name
      loginLabel.text = user.login
      phoneButton.setTitle(user.phone, forState: .Normal)
      emailButton.setTitle(user.email, forState: .Normal)

      locationLabel.text = user.location != nil ? user.location : "not logged"

      let cursus42 = getCursus42FromUser(user)
      if cursus42 == nil || cursus42!.projects.isEmpty {
        disableCell(projectsCell)
      }
      if user.achievements.isEmpty {
        disableCell(achievementsCell)
      }
      if cursus42 == nil || cursus42!.skills.isEmpty {
        disableCell(skillsCell)
      }

      if !user.isStaff {
        crownImage.hidden = true
      }
    }

    self.profileImage.layer.cornerRadius = 50
    self.profileImage.clipsToBounds = true
    tableView.tableFooterView = UIView()

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
    self.profileImage.userInteractionEnabled = true
    self.profileImage.addGestureRecognizer(tapGestureRecognizer)
  }

  func imageTapped(sender: AnyObject) {
    if let user = self.user, let url = NSURL(string: "https://profile.intra.42.fr/users/\(user.login)") {
      UIApplication.sharedApplication().openURL(url)
    }
  }

  private func disableCell(cell: UITableViewCell) {
    cell.contentView.alpha = 0.5
    cell.accessoryType = .None
    cell.userInteractionEnabled = false
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

  private func getCursus42FromUser(user: User) -> Cursus? {
    for c in user.cursus {
      if c.slug == "42" {
        return c
      }
    }
    return nil
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      switch identifier {
      case "ShowProjects":
        if let destinationVC = segue.destinationViewController as? ProjectsTableViewController {
          if let user = self.user, let cursus42 = getCursus42FromUser(user) where cursus42.projects.count > 0 {
            destinationVC.projects = cursus42.projects
          }
        }
      case "ShowAchievements":
        if let destinationVC = segue.destinationViewController as? AchievementsTableViewController {
          if let achievements = user?.achievements where achievements.count > 0 {
            destinationVC.achievements = achievements
          }
        }
      case "ShowSkills":
        if let destinationVC = segue.destinationViewController as? SkillsTableViewController {
          if let user = self.user, let cursus42 = getCursus42FromUser(user) where cursus42.skills.count > 0 {
            destinationVC.skills = cursus42.skills
          }
        }
      default: break
      }
    }
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}

