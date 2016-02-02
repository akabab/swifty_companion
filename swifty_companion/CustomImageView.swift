//
//  CustomImage.swift
//  swifty_companion
//
//  Created by Yoann CRIBIER on 2/2/16.
//  Copyright © 2016 Yoann Cribier. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {

  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderColor: UIColor = UIColor.whiteColor() {
    didSet { layer.borderColor = borderColor.CGColor }
  }
  @IBInspectable var borderWidth:CGFloat = 0.0 {
    didSet { layer.borderWidth = borderWidth }
  }

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
    layer.masksToBounds = true
  }
}
