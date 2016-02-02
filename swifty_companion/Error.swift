//
//  Error.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation
import Alamofire

enum Error {

  static func printFromResponse(response: Response<AnyObject, NSError>) {
    if let requestUrl = response.request?.URLString {
      if let errorDescription = response.result.error?.localizedDescription {
        print("Error: \(requestUrl) -> \(errorDescription)")
      }
      else {
        print("Error: \(requestUrl)")
      }
    }
    else {
//      print("Failed to recover request URL")
    }
  }
}