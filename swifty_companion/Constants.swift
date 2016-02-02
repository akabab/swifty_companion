//
//  Constants.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation

struct Constants {
  struct API {
    static let Host = "https://api.intra.42.fr"
  }

  struct Auth {
    static let ClientId = "ebc8baea88d2ad01ec14db4926010932ee2b92fae182e39b3ad7ec7f07ef36e5"
    static let ClientSecret = "5d9c3d4c6ddd834c77d20a1eded6f3321405c7915fa768c02d71c3973435b8af"
    static let TokenURL = API.Host + "/oauth/token"
  }
}