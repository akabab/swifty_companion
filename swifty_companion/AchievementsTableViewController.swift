//
//  ProjectsTableViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 30/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

class AchievementsTableViewController: UITableViewController {

  var achievements = [Achievement]()
  let cellIdentifier = "AchievementsTableViewCell"

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.estimatedRowHeight = 60.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.setNeedsLayout()
    tableView.layoutIfNeeded()
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return achievements.count
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AchievementsTableViewCell

    let achievement = achievements[indexPath.row]
    cell.nameLabel.text = achievement.name
    cell.descriptionLabel.text = achievement.description

    return cell
  }

}
