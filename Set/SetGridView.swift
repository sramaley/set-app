//
//  SetGridView.swift
//  Set
//
//  Created by Stephen  on 2/15/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import UIKit

@IBDesignable
class SetGridView: UIView {
    
    

    lazy var grid = Grid(layout: .aspectRatio(1.6), frame: bounds)
    override var bounds: CGRect { didSet { grid.frame = bounds } }
    
//    private func createCardView(_ card: SetCard) -> SetCardView {
//        let cardView = SetCardView()
//        cardView.card = card
//        cardView.isOpaque = false
//        let recognizer = UITapGestureRecognizer(target: self,
//                                                action:#selector(handleTap(recognizer:)))
//        cardView.addGestureRecognizer(recognizer)
//        cardFrame.addSubview(cardView)
//        return cardView
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setGrid.cellCount = cards.count
//        for index in 0..<cards.count {
//            createCardView(frame: setGrid[index]!.insetBy(dx: 5, dy: 5), card: cards[index])
//        }
//    }
 

}
