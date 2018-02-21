//
//  SetViewController.swift
//  Set
//
//  Created by Stephen  on 2/5/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    private var game = SetGame()
    
    private var cardToCardView: [SetCard:SetCardView] = [:]
    
    @IBOutlet weak var cardFrame: SetGridView!
    
    @IBAction func dealCards(_ sender: UIButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    
    override func viewDidLayoutSubviews() {
        updateViewFromModel()
    }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func createCardView(_ card: SetCard) -> SetCardView {
        let cardView = SetCardView()
        cardView.card = card
        cardView.isOpaque = false
        let recognizer = UITapGestureRecognizer(target: self,
                                                action:#selector(handleTap(recognizer:)))
        cardView.addGestureRecognizer(recognizer)
        cardFrame.addSubview(cardView)
        return cardView
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let cardView = recognizer.view as? SetCardView {
                game.chooseCard(card: cardView.card)
                updateViewFromModel()
            }
        default:
            break
        }
    }

    private func updateScoreLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .foregroundColor : colors.scoreLabel
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        var index = 0
        var cardView: SetCardView
        cardFrame.grid.cellCount = game.dealtCards.count
        for card in game.dealtCards {
            if let possibleCardView = cardToCardView[card] {
                cardView = possibleCardView
            } else {
                cardView = createCardView(card)
                cardToCardView[card] = cardView
            }
            cardView.frame = cardFrame.grid[index]!.insetBy(dx: gridInset, dy: gridInset)
            cardView.isHidden = false
            if game.selectedCards.contains(card) {
                cardView.layer.borderWidth = selectionBorderWidth
                if let match = game.isMatch {
                    cardView.layer.borderColor = match ? colors.match : colors.mismatch
                } else {
                    cardView.layer.borderColor = colors.selection
                }
            } else {
                cardView.layer.borderWidth = 0.0
            }
            cardView.layer.cornerRadius = selectionCornerRadius
            index += 1
        }
        for card in SetCard.allCards.subtracting(game.dealtCards) {
            if let cardView = cardToCardView.removeValue(forKey: card) {
                cardView.removeFromSuperview()
            }
        }
        updateScoreLabel()
    }
}

extension SetViewController {
    private struct SizeRatio {
        static let gridInsetToCellWidth: CGFloat = 0.03
        static let borderWidthToCellWidth: CGFloat = 0.02
        static let cornerRadiusToCellWidth: CGFloat = 0.05
    }
    
    private struct colors {
        static let mismatch: CGColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        static let match: CGColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        static let selection: CGColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        static let scoreLabel: CGColor = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1)
    }
    
    private var gridInset: CGFloat { return cardFrame.grid.cellSize.width * SizeRatio.gridInsetToCellWidth }
    private var selectionBorderWidth: CGFloat { return cardFrame.grid.cellSize.width * SizeRatio.borderWidthToCellWidth }
    private var selectionCornerRadius: CGFloat { return cardFrame.grid.cellSize.width * SizeRatio.cornerRadiusToCellWidth }
}
