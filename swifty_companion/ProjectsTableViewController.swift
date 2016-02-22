//
//  ProjectsTableViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 30/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

extension ProjectsTableViewController: UISearchControllerDelegate, UISearchResultsUpdating {

  func configureSearchController() {
    // Initialize and perform a minimum configuration to the search controller.
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false

    let searchBar = searchController.searchBar
    searchBar.sizeToFit()

    let navigationBarColor = self.navigationController?.navigationBar.barTintColor
    searchBar.barTintColor = navigationBarColor
    searchBar.layer.borderWidth = 1
    searchBar.layer.borderColor = navigationBarColor?.CGColor

    searchBar.keyboardAppearance = .Dark

    // ensure that the search bar does not remain on the screen if the user navigates to another view controller while the UISearchController is active (when presenting alert for exemple) http://asciiwwdc.com/2014/sessions/228
    self.definesPresentationContext = true

    // Place the search bar view to the tableview headerview.
    tableView.tableHeaderView = searchBar
  }

  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterProjectsForSearchText(searchController.searchBar.text!)
  }

  func filterProjectsForSearchText(searchText: String) {
    filteredProjects = projects.filter { $0.name.lowercaseString.containsString(searchText.lowercaseString) }

    tableView.reloadData()
  }
}

class ProjectsTableViewController: UITableViewController {

  var projects = [Project]()
  var filteredProjects = [Project]()

  var searchController: UISearchController!
  var searching: Bool {
    return searchController.active && searchController.searchBar.text != ""
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureSearchController()

    projects.sortInPlace { $0.name < $1.name }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searching ? filteredProjects.count : projects.count
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "ProjectsTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProjectsTableViewCell

    let project = searching ? filteredProjects[indexPath.row] : projects[indexPath.row]

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
