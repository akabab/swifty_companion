//
//  Oauth.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation
import Alamofire
import p2_OAuth2

class Auth {

  let defaultSettings = [
    "client_id": Constants.Auth.ClientId,
    "client_secret": Constants.Auth.ClientSecret,
    "token_uri": Constants.Auth.TokenURL,
    "username": "",
    "password": "",
    "grant_type": "",
    "secret_in_body": true,
    "keychain": true,
    "verbose": true
  ] as OAuth2JSON

  var oauth2: OAuth2!

  static let sharedInstance = Auth() // Singleton

  private init() {}  // private prevents others from using the default '()' initializer for this class.

  func authenticateWithClientIdAndSecret(settings settings: OAuth2JSON?) {
    var s = settings != nil ? defaultSettings.union(settings!) : defaultSettings
    s["grant_type"] = "client_credentials"

    oauth2 = OAuth2ClientCredentials(settings: s)
  }

  func authenticateWithPassword(settings settings: OAuth2JSON?) {
    var s = settings != nil ? defaultSettings.union(settings!) : defaultSettings
    s["grant_type"] = "password"

    oauth2 = OAuth2PasswordGrant(settings: s)
  }

  func isAuthorized() -> Bool {
    return oauth2.hasUnexpiredAccessToken()
  }

  func authorize() {
    oauth2.onAuthorize = nil
    oauth2.onFailure = nil
    oauth2.authorize()
  }

  func authorize(onSuccess onSuccess: (parameters: OAuth2JSON) -> Void, onFailure: (error: ErrorType?) -> Void) {
    oauth2.onAuthorize = onSuccess
    oauth2.onFailure = onFailure
    oauth2.authorize()
  }
}