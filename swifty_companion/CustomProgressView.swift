//
//  CustomProgressView.swift
//  PaintCodeProgressView
//
//  Created by Yoann CRIBIER on 2/19/16.
//  Copyright © 2016 Yoann CRIBIER. All rights reserved.
//

import UIKit

@IBDesignable
class CustomProgressView: UIView {

  @IBInspectable
  var progress: Float = 0.5 {
    didSet(newProgress) {
      setNeedsDisplay()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func drawRect(rect: CGRect) {
    let frame = self.bounds
    drawWithFrame(frame, progress: self.progress)
  }

  func setBarProgress(progress: Float) {
    self.progress = min(max(0.0, progress), 1.0)
  }

  //// Colors

  @IBInspectable
  var barGradientTopColor: UIColor = UIColor.grayColor()
  @IBInspectable
  var barGradientBottomColor: UIColor = UIColor.darkGrayColor()
  @IBInspectable
  var maskBackgroundColor: UIColor = UIColor.whiteColor()
  @IBInspectable
  var barBackgroundColor: UIColor = UIColor.blackColor()

  @IBInspectable
  var displayText: Bool = false
  @IBInspectable
  var textColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
  @IBInspectable
  var textSize: Int = 13


  //// Drawing Methods

  func drawWithFrame(frame: CGRect = CGRectMake(70, 15, 180, 20), progress: Float = 1.0) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()

    //// Color Declarations

    //// Gradient Declarations
    let barForegroundColor = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [barGradientTopColor.CGColor, barGradientBottomColor.CGColor], [0, 1])!

    //// Subframes
    let barGroup: CGRect = CGRectMake(frame.minX + 4, frame.minY + 3, frame.width - 8, frame.height - 6)
//    let barFrameWidth = CGFloat(progress) * floor(barGroup.width * 1.00000 + 0.5) - floor(barGroup.width * 0.00000 + 0.5)
    let barFrame = CGRectMake(barGroup.minX, barGroup.minY, CGFloat(progress) * barGroup.width, barGroup.height)

//    let barFrame = CGRectMake(barGroup.minX + floor(barGroup.width * 0.00000 + 0.5), barGroup.minY + floor(barGroup.height * 0.00000 + 0.5), barFrameWidth, floor(barGroup.height * 1.00000 + 0.5) - floor(barGroup.height * 0.00000 + 0.5))

    //// background Drawing
    let backgroundPath = UIBezierPath(rect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height))
    barBackgroundColor.setFill()
    backgroundPath.fill()

    //// barGroup
    //// bar Drawing
    let barRect = CGRectMake(barFrame.minX, barFrame.minY, barFrame.width, barFrame.height)
    let barPath = UIBezierPath(rect: barRect)
    CGContextSaveGState(context)
    barPath.addClip()
    CGContextDrawLinearGradient(context, barForegroundColor,
      CGPointMake(barRect.midX, barRect.minY),
      CGPointMake(barRect.midX, barRect.maxY),
      CGGradientDrawingOptions())
    CGContextRestoreGState(context)

    //// mask Drawing
    let maskPath = UIBezierPath()
    maskPath.moveToPoint(CGPointMake(frame.maxX - 8.86, frame.minY + 3))
    maskPath.addLineToPoint(CGPointMake(frame.minX + 8.86, frame.minY + 3))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 6.3, frame.minY + 3.16), controlPoint1: CGPointMake(frame.minX + 7.6, frame.minY + 3), controlPoint2: CGPointMake(frame.minX + 6.97, frame.minY + 3))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 4.71, frame.minY + 4.33), controlPoint1: CGPointMake(frame.minX + 5.56, frame.minY + 3.36), controlPoint2: CGPointMake(frame.minX + 4.98, frame.minY + 3.78))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 4.5, frame.minY + 6.21), controlPoint1: CGPointMake(frame.minX + 4.5, frame.minY + 4.82), controlPoint2: CGPointMake(frame.minX + 4.5, frame.minY + 5.29))
    maskPath.addLineToPoint(CGPointMake(frame.minX + 4.5, frame.maxY - 6.21))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 4.71, frame.maxY - 4.33), controlPoint1: CGPointMake(frame.minX + 4.5, frame.maxY - 5.29), controlPoint2: CGPointMake(frame.minX + 4.5, frame.maxY - 4.82))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 6.3, frame.maxY - 3.16), controlPoint1: CGPointMake(frame.minX + 4.98, frame.maxY - 3.78), controlPoint2: CGPointMake(frame.minX + 5.56, frame.maxY - 3.36))
    maskPath.addLineToPoint(CGPointMake(frame.minX + 6.41, frame.maxY - 3.14))
    maskPath.addCurveToPoint(CGPointMake(frame.minX + 8.86, frame.maxY - 3), controlPoint1: CGPointMake(frame.minX + 6.97, frame.maxY - 3), controlPoint2: CGPointMake(frame.minX + 7.6, frame.maxY - 3))
    maskPath.addLineToPoint(CGPointMake(frame.maxX - 8.86, frame.maxY - 3))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 6.3, frame.maxY - 3.16), controlPoint1: CGPointMake(frame.maxX - 7.6, frame.maxY - 3), controlPoint2: CGPointMake(frame.maxX - 6.97, frame.maxY - 3))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 4.71, frame.maxY - 4.33), controlPoint1: CGPointMake(frame.maxX - 5.56, frame.maxY - 3.36), controlPoint2: CGPointMake(frame.maxX - 4.98, frame.maxY - 3.78))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 4.5, frame.maxY - 6.21), controlPoint1: CGPointMake(frame.maxX - 4.5, frame.maxY - 4.82), controlPoint2: CGPointMake(frame.maxX - 4.5, frame.maxY - 5.29))
    maskPath.addLineToPoint(CGPointMake(frame.maxX - 4.5, frame.minY + 6.21))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 4.71, frame.minY + 4.33), controlPoint1: CGPointMake(frame.maxX - 4.5, frame.minY + 5.29), controlPoint2: CGPointMake(frame.maxX - 4.5, frame.minY + 4.82))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 6.3, frame.minY + 3.16), controlPoint1: CGPointMake(frame.maxX - 4.98, frame.minY + 3.78), controlPoint2: CGPointMake(frame.maxX - 5.56, frame.minY + 3.36))
    maskPath.addLineToPoint(CGPointMake(frame.maxX - 6.41, frame.minY + 3.14))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX - 8.86, frame.minY + 3), controlPoint1: CGPointMake(frame.maxX - 6.97, frame.minY + 3), controlPoint2: CGPointMake(frame.maxX - 7.6, frame.minY + 3))
    maskPath.closePath()
    maskPath.moveToPoint(CGPointMake(frame.maxX, frame.minY + 0))
    maskPath.addCurveToPoint(CGPointMake(frame.maxX, frame.maxY), controlPoint1: CGPointMake(frame.maxX, frame.minY), controlPoint2: CGPointMake(frame.maxX, frame.maxY))
    maskPath.addLineToPoint(CGPointMake(frame.minX, frame.maxY))
    maskPath.addLineToPoint(CGPointMake(frame.minX, frame.minY))
    maskPath.addLineToPoint(CGPointMake(frame.maxX, frame.minY))
    maskPath.addLineToPoint(CGPointMake(frame.maxX, frame.minY + 0))
    maskPath.closePath()
    maskBackgroundColor.setFill()
    maskPath.fill()


    //// Text Drawing
    if displayText {
      let textRect = CGRectMake(frame.minX + 4, frame.minY + 3, frame.width - 8, frame.height - 6)
      let progressPercent = "\(Int(progress * 100)) %"
      let textTextContent = NSString(string: progressPercent)
      let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      textStyle.alignment = .Center

      let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(CGFloat(self.textSize)), NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]

      let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
      CGContextSaveGState(context)
      CGContextClipToRect(context, textRect);
      textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
      CGContextRestoreGState(context)
    }
  }

}
