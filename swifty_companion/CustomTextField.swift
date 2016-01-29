//
//  LoginTextField.swift
//  ios-pilot
//
//  Created by Yoann Cribier on 13/01/16.
//  Copyright © 2016 Openjet. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

  @IBInspectable var insetX: CGFloat = 0
  @IBInspectable var insetY: CGFloat = 0
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderColor: UIColor = UIColor.whiteColor() {
    didSet { layer.borderColor = borderColor.CGColor }
  }
  @IBInspectable var borderWidth:CGFloat = 0.0 {
    didSet { layer.borderWidth = borderWidth }
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
      setCornerRadius(self.cornerRadius)
    }
  }

  private func setCornerRadius(radius: CGFloat) {
    layer.cornerRadius = radius

    // http://stackoverflow.com/questions/4735623/uilabel-layer-cornerradius-negatively-impacting-performance
    layer.masksToBounds = false
    layer.rasterizationScale = UIScreen.mainScreen().scale
    layer.shouldRasterize = true
  }

  // placeholder position
  override func textRectForBounds(bounds: CGRect) -> CGRect {
    return CGRectInset(bounds , insetX , insetY)
  }

  // text position
  override func editingRectForBounds(bounds: CGRect) -> CGRect {
    return CGRectInset(bounds , insetX , insetY)
  }

}
