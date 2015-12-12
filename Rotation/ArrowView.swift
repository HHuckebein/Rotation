//
//  ArrowView.swift
//  Rotation
//
//  Created by Bernd Rabe on 02.12.15.
//  Copyright © 2015 RABE_IT Services. All rights reserved.
//

import UIKit

struct ArrowViewConstants {
    static let LineWidth: CGFloat = 10.0
}

class ArrowView: UIView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, arrowPath(rect).CGPath)
        UIColor.redColor().colorWithAlphaComponent(0.8).setFill()
        CGContextSetLineWidth(context, ArrowViewConstants.LineWidth)
        CGContextSetLineCap(context, .Round)
        CGContextStrokePath(context)
    }
    
    private func arrowPath (rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let pathRect = CGRectInset(rect, ArrowViewConstants.LineWidth, ArrowViewConstants.LineWidth)
        path.moveToPoint(CGPoint(x: CGRectGetMinX(pathRect), y: CGRectGetMaxY(pathRect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMidX(pathRect), y: CGRectGetMinY(pathRect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(pathRect), y: CGRectGetMaxY(pathRect)))
        
        return path
    }
}
