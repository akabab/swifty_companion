//
//  ProjectsTableViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 30/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

class ProjectsTableViewController: UITableViewController {

  var projects = [Project]()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projects.count
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "ProjectsTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProjectsTableViewCell

    let project = projects[indexPath.row]
    cell.nameLabel.text = fixedNameWithProject(project)
    cell.markLabel.text = "\(project.final_mark != nil ? String(project.final_mark!) : "...")"

    return cell
  }

  func fixedNameWithProject(project: Project) -> String {
    if project.slug.hasPrefix("piscine") {
      let split = project.slug.componentsSeparatedByString("-")
      if split.count == 3 {
        return "Piscine \(split[1]) - \(project.name)"
      }
    }
    return project.name
  }

}
