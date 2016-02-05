//
//  AppDelegate.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit
import Alamofire
import p2_OAuth2

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    print("Authenticating..")
    Auth.sharedInstance.authenticateWithClientIdAndSecret(settings: nil)
//    print("Flush..")
//    Auth.sharedInstance.oauth2.forgetTokens() // TMP
    print("Authorizing..")
    Auth.sharedInstance.authorize(
      onSuccess: { parameters in
        dispatch_async(dispatch_get_main_queue()) {
          print("Successfully logged in with parameters: \(parameters)")
        }
      },
      onFailure: { error in
        dispatch_async(dispatch_get_main_queue()) {
          guard let error = error else {
            print("Failed without error")
            return
          }

          guard let oauthError = error as? OAuth2Error else {
            print(error)
            return
          }
          print(oauthError)
        }
    })

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

