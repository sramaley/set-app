//
//  OldViewController.swift
//  Set
//
//  Created by Stephen  on 2/17/18.
//  Copyright © 2018 Stephen . All rights reserved.
//
/*
import UIKit

class OldViewController: UIViewController {
    
    private var game = SetGame()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var cards: [SetCard?] = Array(repeating: nil, count: cardButtons.count)
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            if let card = cards[cardNumber] {
                game.chooseCard(card: card)
            }
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func dealCards(_ sender: UIButton) {
        if game.dealtCards.count < cardButtons.count {
            game.dealThreeCards()
            
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .foregroundColor : #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        var index = 0
        if game.dealtCards.count > cardButtons.count {
            print("how tf did that happen")
            return // fix this
        }
        for card in game.dealtCards {
            let button = cardButtons[index]
            button.setAttributedTitle(symbols(for: card), for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.9665141834, blue: 0.957263377, alpha: 1)
            if game.selectedCards.contains(card) {
                button.layer.borderWidth = 3.0
                if let match = game.isMatch {
                    button.layer.borderColor = match ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                } else {
                    button.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                }
            } else {
                button.layer.borderWidth = 0.0
            }
            button.layer.cornerRadius = 8.0
            cards[index] = card
            index += 1
        }
        while index < cardButtons.count {
            let button = cardButtons[index]
            button.setAttributedTitle(NSAttributedString(string: "" ), for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
            button.layer.borderWidth = 0.0
            cards[index] = nil
            index += 1
        }
        updateScoreLabel()
    }
    
    private func symbols(for card: SetCard) -> NSAttributedString? {
        var attributes = [NSAttributedStringKey:Any]()
        var shape: Character
        var multiplier: Int
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        
        switch card.shape {
        case .one:
            shape = "▲"
        case .two:
            shape = "●"
        case .three:
            shape = "■"
        }
        switch card.number {
        case .one:
            multiplier = 1
        case .two:
            multiplier = 2
        case .three:
            multiplier = 3
        }
        switch card.color {
        case .one:
            red = 0.8
            green = 0.2
            blue = 0.1
        case .two:
            red = 0.1
            green = 0.9
            blue = 0.2
        case .three:
            red = 0.2
            green = 0.1
            blue = 0.8
        }
        switch card.shading {
        case .one:
            attributes[.foregroundColor] = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
        case .two:
            attributes[.foregroundColor] = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 0.2)
        case .three:
            attributes[.strokeColor] = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
            attributes[.strokeWidth] = 8.0
        }
        return NSAttributedString(string: String(repeating: shape, count: multiplier), attributes: attributes)
    }
}
*/

