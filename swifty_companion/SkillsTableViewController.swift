//
//  ProjectsTableViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 30/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

class SkillsTableViewController: UITableViewController {

  var skills = [Skill]()
  let cellIdentifier = "SkillsTableViewCell"

  override func viewDidLoad() {
    super.viewDidLoad()

    sortSkillsByLevel()
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return skills.count
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SkillsTableViewCell

    let skill = skills[indexPath.row]
    cell.nameLabel.text = skill.name
    cell.levelLabel.text = String(skill.level)

    return cell
  }

  private func sortSkillsByLevel() {
    skills.sortInPlace { return $0.level > $1.level }
  }

}
