//
//  CustomButton.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 29/01/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit
import PureLayout

enum ButtonStatus {
  case Idle
  case Loading
}

@IBDesignable
class CustomButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat = 0

  private var savedTitle: String = ""

  var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)

  var status: ButtonStatus = .Idle {
    didSet {
      switch self.status {
      case .Idle:
        self.setTitle(self.savedTitle, forState: .Normal)
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
        self.layer.opacity = 1.0
        self.userInteractionEnabled = true
      case .Loading:
        self.savedTitle = self.titleLabel?.text ?? ""
        self.setTitle("", forState: .Normal)
        self.addSubview(activityIndicator)
        self.activityIndicator.autoCenterInSuperview()
        self.activityIndicator.startAnimating()
        self.layer.opacity = 0.4
        self.userInteractionEnabled = false
      }
    }
  }

  // MARK: - Initializers

  // IBDesignables require both of these inits, otherwise we'll get an error: IBDesignable View Rendering times out. http://stackoverflow.com/questions/26772729/ibdesignable-view-rendering-times-out
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Life cycle

  override func layoutSubviews() {
    super.layoutSubviews()

    if cornerRadius > 0 {
      setCornerRadius(cornerRadius)
    }
  }

  private func setCornerRadius(radius: CGFloat) {
    layer.cornerRadius = radius

    // http://stackoverflow.com/questions/4735623/uilabel-layer-cornerradius-negatively-impacting-performance
    layer.masksToBounds = false
    layer.rasterizationScale = UIScreen.mainScreen().scale
    layer.shouldRasterize = true
  }

}
