//
//  Router.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  static let baseURL = NSURL(string: Constants.API.Host + "/v2")!

  case Users(id: String)

  var method: Alamofire.Method {
    // switch self {
    //    case .Leg: return .GET
    //    ...
    return .GET
  }

  var route: (path: String, parameters: [String: AnyObject]?) {
    switch self {
    case .Users(let id): return ("/users/\(id)", nil)
    }
  }

  var needAuthorize: Bool {
    return true
  }

  var url: NSURL {
    return Router.baseURL.URLByAppendingPathComponent(self.route.path)
  }

  var URLRequest: NSMutableURLRequest {
    var request: NSURLRequest

    // Handle Authorization
    if self.needAuthorize {
      let auth = Auth.sharedInstance
      if !auth.isAuthorized() {
        auth.authorize()
      }
      // OAuth2 signed URLRequest
      request = auth.oauth2.request(forURL: url) as NSMutableURLRequest
    }
    else {
      request = NSURLRequest(URL: self.url)
    }

    return Alamofire.ParameterEncoding.URL.encode(request, parameters: route.parameters).0
  }

}