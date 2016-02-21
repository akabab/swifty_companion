//
//  UserDetailViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

extension UserDetailTableViewController: CNContactViewControllerDelegate {
  func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {

    if contact != nil {
      addButtonItem.enabled = false
    }

    dismissViewControllerAnimated(true, completion: nil)
  }

  func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
    return true
  }
}

class UserDetailTableViewController: UITableViewController {

  var user: User!

  @IBOutlet weak var titleItem: UINavigationItem!
  @IBOutlet weak var addButtonItem: UIBarButtonItem!

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

  @IBOutlet weak var progressBar: CustomProgressView!
  @IBOutlet weak var levelLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Contact Feature
    addButtonItem.enabled = false
    checkContactExistence()

    // Image
    profileImage.imageFromUrl(user.image_url, contentMode: .ScaleAspectFill)
    if !user.isStaff {
      crownImage.hidden = true
    }

    // Name / Login
    nameLabel.text = user.name
    loginLabel.text = user.login

    // Phone / Mail / Location
    phoneButton.setTitle(user.phone, forState: .Normal)
    emailButton.setTitle(user.email, forState: .Normal)
    locationLabel.text = user.location != nil ? user.location : "not logged"

    let cursus42 = getCursus42FromUser(user)

    // Level
    if cursus42 != nil {
      let level = Int(cursus42!.level)
      let percent = Int(cursus42!.level * 100) % 100
      levelLabel.text = "Level \(level) - \(percent)%"

      progressBar.setBarProgress(Float(percent) / 100)
    }
    else {
      levelLabel.text = ""
      progressBar.setBarProgress(0)
    }

    // Projects
    if cursus42 == nil || cursus42!.projects.isEmpty {
      disableCell(projectsCell)
    }

    // Achievements
    if user.achievements.isEmpty {
      disableCell(achievementsCell)
    }

    // Skills
    if cursus42 == nil || cursus42!.skills.isEmpty {
      disableCell(skillsCell)
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

  @IBAction func addAsContact(sender: UIBarButtonItem) {
    let contact = CNMutableContact()

    if let image = profileImage.image {
      contact.imageData = UIImageJPEGRepresentation(image, 1.0)
    }

    contact.givenName = user.name
    contact.nickname = user.login
    contact.organizationName = "42"

    if let phoneNumber = user.phone {
      contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phoneNumber))]
    }

    if !user.email.isEmpty {
      contact.emailAddresses = [CNLabeledValue(label: "42", value: user.email)]
    }

    contact.urlAddresses = [CNLabeledValue(label: "intra 42", value: "https://profile.intra.42.fr/users/\(user.login)")]

    let contactVC = CNContactViewController(forNewContact: contact)
    contactVC.delegate = self

    let contactNavigationVC = UINavigationController(rootViewController: contactVC)

    self.presentViewController(contactNavigationVC, animated: true, completion: nil)
  }

  func checkContactExistence() {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {

      let store = CNContactStore()
      let predicate: NSPredicate = CNContact.predicateForContactsMatchingName(self.user.login)
      let keyToFetch = [CNContactNicknameKey]

      do {
        let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keyToFetch)
        if contacts.isEmpty {
          dispatch_async(dispatch_get_main_queue()) {
            self.addButtonItem.enabled = true
          }
        }
        else {
          print("contact already exists")
        }
      }
      catch {
        print(error)
      }
    }
    
  }

  private func disableCell(cell: UITableViewCell) {
    cell.contentView.alpha = 0.5
    cell.accessoryType = .None
    cell.userInteractionEnabled = false
  }

  @IBAction func phoneButtonPressed() {

    guard let phoneNumber = phoneButton.currentTitle?.removeWhitespace() else {
      return
    }

    let alert = UIAlertController(title: phoneNumber, message: "", preferredStyle: .ActionSheet)
    let firstAction = UIAlertAction(title: "Call", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.callPhoneNumber(phoneNumber)
    }

    let secondAction = UIAlertAction(title: "Send Message", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.messagePhoneNumber(phoneNumber)
    }

    alert.addAction(firstAction)
    alert.addAction(secondAction)
    presentViewController(alert, animated: true, completion: nil)
  }

  @IBAction func emailButtonPressed() {
    if let to = emailButton.currentTitle?.removeWhitespace() {
      mailTo(to)
    }
  }

  private func mailTo(to: String) {
    guard let url = NSURL(string: "mailto://\(to)") else {
      print("Invalid format for email: \(to)")
      return
    }

    UIApplication.sharedApplication().openURL(url)
  }

  private func messagePhoneNumber(phoneNumber: String) {
    guard let url = NSURL(string: "sms://\(phoneNumber)") else {
      print("Invalid format for phone number: \(phoneNumber)")
      return
    }

    UIApplication.sharedApplication().openURL(url)
  }

  private func callPhoneNumber(phoneNumber: String, shouldPrompt: Bool = false) {
    guard let url = NSURL(string: "tel\(shouldPrompt ? "prompt" : "")://\(phoneNumber)") else {
      print("Invalid format for phone number: \(phoneNumber)")
      return
    }

    UIApplication.sharedApplication().openURL(url)
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

