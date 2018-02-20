//
//  SetSymbolView.swift
//  Set
//
//  Created by Stephen  on 2/13/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import UIKit

@IBDesignable
class SetSymbolView: UIView {

    var color = SetCard.Property.one
    var shape = SetCard.Property.three
    var shading = SetCard.Property.three
    
    
    override func draw(_ rect: CGRect) {
        let path: UIBezierPath
        switch shape {
        case .one:
            path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        case .two:
            path = UIBezierPath()
            path.move(to: topMiddle)
            path.addLine(to: middleRight)
            path.addLine(to: bottomMiddle)
            path.addLine(to: middleLeft)
            path.close()
        case .three:
            path = UIBezierPath()
            path.move(to: squiggleTop)
            path.addCurve(to: squiggleBottom, controlPoint1: rightControlPoint1, controlPoint2: rightControlPoint2)
            path.addCurve(to: squiggleTop, controlPoint1: leftControlPoint1, controlPoint2: leftControlPoint2)
            path.close()
        }
        path.addClip()
        switch color {
        case .one:
            UIColor.green.setFill()
            UIColor.green.setStroke()
        case .two:
            UIColor.red.setFill()
            UIColor.red.setStroke()
        case .three:
            UIColor.blue.setFill()
            UIColor.blue.setStroke()
        }
        switch shading {
        case .one:
            path.fill()
        case .two:
            path.lineWidth = outlineStrokeSize
            path.stroke()
        case .three:
            let stripes = UIBezierPath()
            for index in 0..<numberOfStripes {
                stripes.move(to: CGPoint(x: 0, y: bounds.height * CGFloat(index) / CGFloat(numberOfStripes)))
                stripes.addLine(to: CGPoint(x: bounds.width, y: bounds.height * CGFloat(index) / CGFloat(numberOfStripes)))
            }
            stripes.lineWidth = stripeStrokeSize
            stripes.stroke()
            path.lineWidth = outlineStrokeSize
            path.stroke()
        }
        
    }
    
    private struct SizeRatio {
        static let cornerRadiusToBoundsWidth: CGFloat = 0.75
        static let squiggleTop: CGFloat = 0.75
        static let controlPoint1: CGFloat = 0.0
        static let controlPoint2: CGFloat = 2.0
        static let outlineStrokeToBoundsWidth: CGFloat = 0.05
        static let stripeStrokeToBoundsWidth: CGFloat = 0.02
    }
    
    private let numberOfStripes = 16

    private var cornerRadius: CGFloat { return bounds.width * SizeRatio.cornerRadiusToBoundsWidth }
    
    private var outlineStrokeSize: CGFloat { return bounds.width * SizeRatio.outlineStrokeToBoundsWidth }
    private var stripeStrokeSize: CGFloat { return bounds.width * SizeRatio.stripeStrokeToBoundsWidth }
    
    private var topMiddle: CGPoint { return CGPoint(x: bounds.midX, y: 0) }
    private var bottomMiddle: CGPoint { return CGPoint(x: bounds.midX, y: bounds.height) }
    private var middleRight: CGPoint { return CGPoint(x: bounds.width , y: bounds.midY) }
    private var middleLeft: CGPoint { return CGPoint(x: 0, y: bounds.midY) }
    
    private var squiggleTop: CGPoint { return CGPoint(x: bounds.width * SizeRatio.squiggleTop, y: 0) }
    private var rightControlPoint1: CGPoint { return CGPoint(x: bounds.width * SizeRatio.controlPoint1, y: bounds.height * 0.5) }
    private var rightControlPoint2: CGPoint { return CGPoint(x: bounds.width * SizeRatio.controlPoint2, y: bounds.height * 0.5) }
    private var squiggleBottom: CGPoint { return CGPoint(x: bounds.width * (1 - SizeRatio.squiggleTop), y: bounds.height) }
    private var leftControlPoint1: CGPoint { return CGPoint(x: bounds.width * (1 - SizeRatio.controlPoint1), y: bounds.height * 0.5) }
    private var leftControlPoint2: CGPoint { return CGPoint(x: bounds.width * (1 - SizeRatio.controlPoint2), y: bounds.height * 0.5) }

}

