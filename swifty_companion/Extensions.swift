//
//  Extentions.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func replace(string:String, replacement:String) -> String {
    return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
  }

  func removeWhitespace() -> String {
    return self.replace(" ", replacement: "")
  }
}

extension Dictionary {
  mutating func unionByOverwriting(
    dictionary: Dictionary<Key, Value>) {
      for (key, value) in dictionary {
        self[key] = value
      }
  }

  // Thanks Airspeed Velocity
  mutating func unionByOverwriting<S: SequenceType where
    S.Generator.Element == (Key,Value)>(sequence: S) {
      for (key, value) in sequence {
        self[key] = value
      }
  }

  func each (each: (Key, Value) -> ()) {
    for (key, value) in self {
      each(key, value)
    }
  }

  func union (dictionaries: Dictionary...) -> Dictionary {
    var result = self

    dictionaries.each { (dictionary) -> Void in
      dictionary.each { (key, value) -> Void in
        _ = result.updateValue(value, forKey: key)
      }
    }
    return result
  }

}

extension Array {
  func each (call: (Element) -> ()) {
    for item in self {
      call(item)
    }
  }
}

extension UIColor {
  public convenience init?(hexString: String) {
    let r, g, b, a: CGFloat

    if hexString.hasPrefix("#") {
      let start = hexString.startIndex.advancedBy(1)
      let hexColor = hexString.substringFromIndex(start)

      if hexColor.characters.count == 8 {
        let scanner = NSScanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexLongLong(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255

          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      }
    }
    return nil
  }
}

extension UIImageView {
  public func imageFromUrl(urlString: String) {
    if let url = NSURL(string: urlString) {
      let request = NSURLRequest(URL: url)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        if let imageData = data as NSData? {
          self.image = UIImage(data: imageData)
        }
        else {
          print("Failed to recover image")
        }
      }
    }
  }
}