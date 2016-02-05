//
//  SearchViewController.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit
import p2_OAuth2
import Alamofire
import Unbox

enum SearchError: CustomStringConvertible {
  case EmptyField
  case UnknownLogin

  var description: String {
    switch self {
    case .EmptyField:
      return "You must provide a login"
    case .UnknownLogin:
      return "Login does not exist"
    }
  }
}

extension SearchViewController: UITextFieldDelegate {

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    switch textField {
    case self.loginTextField:
      self.search()
    default:
      break
    }
    return false
  }
}

class SearchViewController: UIViewController {

  @IBOutlet weak var loginTextField: CustomTextField!
  @IBOutlet weak var searchButton: CustomButton!
  @IBOutlet weak var messageLabel: UILabel!

  var user: User? = nil

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.hidden = true
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.hidden = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loginTextField.delegate = self
  }

  @IBAction func search() {
    self.dismissKeyboard()

    resetValidationStyle()
    messageLabel.text = ""

    self.user = nil

    if let login = loginTextField.text where !login.isEmpty {
      searchLogin(login)
    }
    else {
      self.messageLabel.text = "\(SearchError.EmptyField)"
      self.validateTextField(self.loginTextField, valid: false)
    }
  }

  func searchLogin(login: String) {
    searchButton.status = .Loading

    Alamofire.request(Router.Users(id: login)).validate().responseData { response in
      self.searchButton.status = .Idle

      switch response.result {
      case .Success:
        print("Validation Successful")
      case .Failure(let error):
        print(error)
        if let res = response.response where res.statusCode == 404 {
          self.messageLabel.text = "\(SearchError.UnknownLogin)"
          self.validateTextField(self.loginTextField, valid: false)
        }
      }

      if let data = response.result.value {
        do {
          self.user = try UnboxOrThrow(data) as User
          self.performSegueWithIdentifier("ShowUser", sender: nil)
        }
        catch {
          print(error)
        }
      }
    }
  }

  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    return false
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUser" {
      if let destinationVC = segue.destinationViewController as? UserDetailTableViewController {
        destinationVC.user = self.user
      }
    }
  }

  func resetValidationStyle() {
    validateTextField(self.loginTextField, valid: true)
  }

  func validateTextField(textField: UITextField, valid: Bool) {
    var borderWidth: CGFloat = 0
    var borderColor: CGColor = UIColor.whiteColor().CGColor

    if !valid {
      borderWidth = 2
      borderColor = UIColor.redColor().CGColor
    }
    textField.layer.borderWidth = borderWidth
    textField.layer.borderColor = borderColor
  }

  func alert(title title: String, message: String, detailedMessage: String?, style: UIAlertControllerStyle) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)

    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    if let detailedMessage = detailedMessage {
      alert.addAction(UIAlertAction(title: "Detail", style: UIAlertActionStyle.Default) { action in
        self.alert(title: "Detail", message: detailedMessage, detailedMessage: nil, style: .Alert)
        })
    }
    self.presentViewController(alert, animated: true, completion: nil)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.dismissKeyboard()
  }

  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
}
