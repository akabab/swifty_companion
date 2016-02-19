//
//  ProgressBarView.swift
//  swifty_companion
//
//  Created by Yoann Cribier on 11/02/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressBarView: UIView {
  override func drawRect(rect: CGRect) {
    ProgressBar.drawCanvas1()
  }
}
