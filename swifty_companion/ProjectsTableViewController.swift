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

    let final_mark = project.final_mark
    cell.markLabel.text = final_mark != nil ? String(final_mark!) : "..."
    if let mark = final_mark {
      setMarkColorForCell(cell, mark: mark)
    }

    return cell
  }

  private func setMarkColorForCell(cell: ProjectsTableViewCell, mark: Int) {
    cell.markLabel.alpha = CGFloat(Double(mark) * 0.5 / 125 + 0.5)
//      switch mark {
//      case 0..<50: cell.markLabel.textColor = UIColor.redColor()
//      case 50..<100: cell.markLabel.textColor = UIColor.orangeColor()
//      case 100...200: cell.markLabel.textColor = UIColor.greenColor()
//      default: break
//      }
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
