//
//  ProgressBar.swift
//  ProgressBar
//
//  Created by Akabab on 11/02/16.
//  Copyright (c) 2016 Focus. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class ProgressBar : NSObject {

    //// Cache

    private struct Cache {
        static let barGradientColor1: UIColor = UIColor(red: 0.365, green: 0.662, blue: 0.873, alpha: 1.000)
        static let barGradientColor2: UIColor = UIColor(red: 0.057, green: 0.375, blue: 0.792, alpha: 1.000)
    }

    //// Colors

    public class var barGradientColor1: UIColor { return Cache.barGradientColor1 }
    public class var barGradientColor2: UIColor { return Cache.barGradientColor2 }

    //// Drawing Methods

    public class func drawCanvas1() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let maskBackgroundColor = UIColor(red: 0.173, green: 0.196, blue: 0.247, alpha: 1.000)
        let barBackgroundColor = UIColor(red: 0.286, green: 0.286, blue: 0.286, alpha: 1.000)

        //// Gradient Declarations
        let barForegroundColor = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [ProgressBar.barGradientColor1.CGColor, ProgressBar.barGradientColor2.CGColor], [0, 1])!

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(74, 17, 163, 16))
        barBackgroundColor.setFill()
        rectanglePath.fill()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(74, 17, 107, 16))
        CGContextSaveGState(context)
        rectangle2Path.addClip()
        CGContextDrawLinearGradient(context, barForegroundColor, CGPointMake(127.5, 17), CGPointMake(127.5, 33), CGGradientDrawingOptions())
        CGContextRestoreGState(context)


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(232.41, 17))
        bezierPath.addLineToPoint(CGPointMake(78.59, 17))
        bezierPath.addCurveToPoint(CGPointMake(75.89, 17.22), controlPoint1: CGPointMake(77.27, 17), controlPoint2: CGPointMake(76.61, 17))
        bezierPath.addCurveToPoint(CGPointMake(74.22, 18.89), controlPoint1: CGPointMake(75.12, 17.51), controlPoint2: CGPointMake(74.51, 18.12))
        bezierPath.addLineToPoint(CGPointMake(74.2, 19.01))
        bezierPath.addCurveToPoint(CGPointMake(74, 21.59), controlPoint1: CGPointMake(74, 19.61), controlPoint2: CGPointMake(74, 20.27))
        bezierPath.addLineToPoint(CGPointMake(74, 28.41))
        bezierPath.addCurveToPoint(CGPointMake(74.22, 31.11), controlPoint1: CGPointMake(74, 29.73), controlPoint2: CGPointMake(74, 30.39))
        bezierPath.addCurveToPoint(CGPointMake(75.89, 32.78), controlPoint1: CGPointMake(74.51, 31.88), controlPoint2: CGPointMake(75.12, 32.49))
        bezierPath.addLineToPoint(CGPointMake(76.01, 32.8))
        bezierPath.addCurveToPoint(CGPointMake(78.59, 33), controlPoint1: CGPointMake(76.61, 33), controlPoint2: CGPointMake(77.27, 33))
        bezierPath.addLineToPoint(CGPointMake(232.41, 33))
        bezierPath.addCurveToPoint(CGPointMake(235.11, 32.78), controlPoint1: CGPointMake(233.73, 33), controlPoint2: CGPointMake(234.39, 33))
        bezierPath.addCurveToPoint(CGPointMake(236.78, 31.11), controlPoint1: CGPointMake(235.88, 32.49), controlPoint2: CGPointMake(236.49, 31.88))
        bezierPath.addLineToPoint(CGPointMake(236.8, 30.99))
        bezierPath.addCurveToPoint(CGPointMake(237, 28.41), controlPoint1: CGPointMake(237, 30.39), controlPoint2: CGPointMake(237, 29.73))
        bezierPath.addLineToPoint(CGPointMake(237, 21.59))
        bezierPath.addCurveToPoint(CGPointMake(236.78, 18.89), controlPoint1: CGPointMake(237, 20.27), controlPoint2: CGPointMake(237, 19.61))
        bezierPath.addCurveToPoint(CGPointMake(235.11, 17.22), controlPoint1: CGPointMake(236.49, 18.12), controlPoint2: CGPointMake(235.88, 17.51))
        bezierPath.addLineToPoint(CGPointMake(234.99, 17.2))
        bezierPath.addCurveToPoint(CGPointMake(232.41, 17), controlPoint1: CGPointMake(234.39, 17), controlPoint2: CGPointMake(233.73, 17))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(245.15, 13))
        bezierPath.addCurveToPoint(CGPointMake(245.15, 37), controlPoint1: CGPointMake(245.15, 13), controlPoint2: CGPointMake(245.15, 37))
        bezierPath.addLineToPoint(CGPointMake(65.85, 37))
        bezierPath.addLineToPoint(CGPointMake(65.85, 13))
        bezierPath.addLineToPoint(CGPointMake(245.15, 13))
        bezierPath.addLineToPoint(CGPointMake(245.15, 13))
        bezierPath.closePath()
        maskBackgroundColor.setFill()
        bezierPath.fill()
    }

}