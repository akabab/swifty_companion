//
//  User.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation
import Unbox

struct User: Unboxable {
  let id: Int
  let login: String
  let name: String
  let email: String
  let phone: String?
  let image_url: String
  let location: String?

  let achievements: [Achievement]

  let cursus: [Cursus]

  init(unboxer: Unboxer) {
    self.id = unboxer.unbox("id")
    self.name = unboxer.unbox("displayname")
    self.login = unboxer.unbox("login")
    self.email = unboxer.unbox("email")
    self.phone = unboxer.unbox("phone")
    self.image_url = unboxer.unbox("image_url")
    self.location = unboxer.unbox("location")

    self.achievements = unboxer.unbox("achievements")

    self.cursus = unboxer.unbox("cursus")
  }
}

struct Achievement: Unboxable {
  let id: Int
  let name: String
  let description: String
  let users_url: String

  init(unboxer: Unboxer) {
    self.id = unboxer.unbox("id")
    self.name = unboxer.unbox("name")
    self.description = unboxer.unbox("description")
    self.users_url = unboxer.unbox("users_url")
  }
}

struct Cursus: Unboxable {
  let id: Int
  let name: String
  let slug: String
  let level: Float
  let grade: String?

  let projects: [Project]

  let skills: [Skill]

  let created_at: NSDate
  let updated_at: NSDate?

  init(unboxer: Unboxer) {
    self.id = unboxer.unbox("cursus.id")
    self.name = unboxer.unbox("cursus.name")
    self.slug = unboxer.unbox("cursus.slug")
    self.level = unboxer.unbox("level")
    self.grade = unboxer.unbox("grade")

    self.projects = unboxer.unbox("projects")

    self.skills = unboxer.unbox("skills")

    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
    self.created_at = unboxer.unbox("cursus.created_at", formatter: dateFormatter)
    self.updated_at = unboxer.unbox("cursus.updated_at", formatter: dateFormatter)
  }
}

struct Project: Unboxable {
  let id: Int
  let name: String
  let slug: String
  let final_mark: Int?
  let occurrence: Int
  let projects_user_id: Int
  let teams_ids: [Int]

  let registered_at: NSDate
  let retriable_at: NSDate?

  init(unboxer: Unboxer) {
    self.id = unboxer.unbox("id")
    self.name = unboxer.unbox("name")
    self.slug = unboxer.unbox("slug")
    self.final_mark = unboxer.unbox("final_mark")
    self.occurrence = unboxer.unbox("occurrence")
    self.projects_user_id = unboxer.unbox("projects_user_id")
    self.teams_ids = unboxer.unbox("teams_ids")

    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
    self.registered_at = unboxer.unbox("registered_at", formatter: dateFormatter)
    self.retriable_at = unboxer.unbox("retriable_at", formatter: dateFormatter)
  }
}

struct Skill: Unboxable {
  let id: Int
  let name: String
  let level: Float

  init(unboxer: Unboxer) {
    self.id = unboxer.unbox("id")
    self.name = unboxer.unbox("name")
    self.level = unboxer.unbox("level")
  }
}
