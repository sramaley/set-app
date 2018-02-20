//
//  SetCardView.swift
//  Set
//
//  Created by Stephen  on 2/12/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import UIKit

@IBDesignable
class SetCardView: UIView {

    
    //var card = SetCard(id: 0)!
    var card = SetCard(number: .two, shape: .two, color: .two, shading: .two)
    var leftSymbol, middleSymbol, rightSymbol: SetSymbolView?

    override func draw(_ rect: CGRect) {
        let cardBack = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        cardBack.fill()
    }
    
    private func createSymbol(frame: CGRect) -> SetSymbolView{
        let symbol = SetSymbolView(frame: frame)
        symbol.color = card.color
        symbol.shape = card.shape
        symbol.shading = card.shading
        symbol.isOpaque = false
        addSubview(symbol)
        return symbol
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch card.number {
        case .one:
            if let symbol = middleSymbol {
                symbol.frame = middle
            } else {
                middleSymbol = createSymbol(frame: middle)
            }
        case .two:
            if let symbol1 = leftSymbol, let symbol2 = rightSymbol {
                symbol1.frame = centerLeft
                symbol2.frame = centerRight
            } else {
                leftSymbol = createSymbol(frame: centerLeft)
                rightSymbol = createSymbol(frame: centerRight)
            }
        case .three:
            if let symbol1 = leftSymbol, let symbol2 = middleSymbol, let symbol3 = rightSymbol {
                symbol1.frame = farLeft
                symbol2.frame = middle
                symbol3.frame = farRight
            } else {
                leftSymbol = createSymbol(frame: farLeft)
                middleSymbol = createSymbol(frame: middle)
                rightSymbol = createSymbol(frame: farRight)
            }
        }
    }
}

extension SetCardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsWidth: CGFloat = 0.06
        static let symbolHeightToBoundsHeight: CGFloat = 0.9
        static let symbolWidthToBoundsWidth: CGFloat = 0.3
        static let spacingToBoundsWidth: CGFloat = 0.01
    }
    
    private var cornerRadius: CGFloat { return bounds.width * SizeRatio.cornerRadiusToBoundsWidth }
    private var middle: CGRect { return makeRectForXPosition(x: bounds.midX - (bounds.width * SizeRatio.symbolWidthToBoundsWidth * 0.5)) }
    private var centerLeft: CGRect { return makeRectForXPosition(x: bounds.midX - (bounds.width * (SizeRatio.symbolWidthToBoundsWidth + (SizeRatio.spacingToBoundsWidth * 0.5)))) }
    private var centerRight: CGRect { return makeRectForXPosition(x: bounds.midX + (bounds.width * SizeRatio.spacingToBoundsWidth * 0.5)) }
    private var farLeft: CGRect { return makeRectForXPosition(x: bounds.midX - (bounds.width * ((1.5 * SizeRatio.symbolWidthToBoundsWidth) + SizeRatio.spacingToBoundsWidth))) }
    private var farRight: CGRect { return makeRectForXPosition(x: bounds.midX + (bounds.width * ((0.5 * SizeRatio.symbolWidthToBoundsWidth) + SizeRatio.spacingToBoundsWidth))) }
   
    private func makeRectForXPosition(x: CGFloat) -> CGRect {
        return CGRect(x: x,
                      y: bounds.height * 0.5 * (1 - SizeRatio.symbolHeightToBoundsHeight),
                      width: bounds.width * SizeRatio.symbolWidthToBoundsWidth,
                      height: bounds.height * SizeRatio.symbolHeightToBoundsHeight)
    }
}
