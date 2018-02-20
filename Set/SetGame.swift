//
//  SetGame.swift
//  Set
//
//  Created by Stephen  on 2/5/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import Foundation

struct SetGame {
    
    private var cardsInDeck = [SetCard]()
    private(set) var dealtCards = Set<SetCard>()
    private(set) var matchedCards = Set<SetCard>()
    private(set) var selectedCards = Set<SetCard>()
    private(set) var isMatch: Bool?
    private(set) var score = 0
    private(set) var timeSinceLastFoundSet = Date()
    
    let sizeOfDeck = 81
    
    init() {
        var unshuffledCards = SetCard.allCards.sorted(by: <)
        while !unshuffledCards.isEmpty {
            cardsInDeck += [unshuffledCards.remove(at: unshuffledCards.count.arc4random)]
        }
        for _ in 0..<12 { dealtCards.insert(cardsInDeck.removeFirst()) }
    }
    
    mutating func dealThreeCards() {
        if let match = isMatch, match {
            dealtCards.subtract(selectedCards)
            matchedCards.formUnion(selectedCards)
            selectedCards.removeAll()
            isMatch = nil
        }
        if !cardsInDeck.isEmpty {
            for _ in 0..<3 { dealtCards.insert(cardsInDeck.removeFirst()) }
        }
    }
    
    mutating func dealWithMatch() {
        dealtCards.subtract(selectedCards)
        matchedCards.formUnion(selectedCards)
        if dealtCards.count < 12 {
            dealThreeCards()
        }
    }
    
    mutating func chooseCard(card: SetCard) {
        if selectedCards.contains(card) {
            if let match = isMatch { //are there 3 cards?
                if match {
                    dealWithMatch()
                    selectedCards = []
                } else {
                    selectedCards = [card]
                }
                isMatch = nil
            } else {
                selectedCards.remove(card)
            }
        } else if selectedCards.count < 2{
            selectedCards.insert(card)
        } else if selectedCards.count == 2 {
            selectedCards.insert(card)
            isMatch = checkMatch(selectedCards)
        } else {
            if isMatch! {
                dealWithMatch()
            }
            selectedCards = [card]
            isMatch = nil
        }
    }
    
    func containsSet()->(SetCard, SetCard, SetCard)? {
        let sortedCards = dealtCards.sorted(by: <)
        var cardOne, cardTwo: SetCard
        for indexOne in 0..<sortedCards.count-1 {
            for indexTwo in indexOne..<sortedCards.count {
                cardOne = sortedCards[indexOne]
                cardTwo = sortedCards[indexTwo]
                let cardThree = cardThatCompletesSet(cardOne, cardTwo)
                if dealtCards.contains(cardThree) {
                    return (cardOne, cardTwo, cardThree)
                }
            }
        }
        return nil
    }
    
    private func cardThatCompletesSet(_ cardOne: SetCard, _ cardTwo: SetCard) -> SetCard {
        var propertyValues: [SetCard.Property?] = Array(repeating: nil, count: 4)
        for index in 0..<4 {
            if  cardOne.properties[index] == cardTwo.properties[index] {
                propertyValues[index] = cardOne.properties[index]
            } else if cardOne.properties[index].rawValue + cardTwo.properties[index].rawValue == 3 {
                propertyValues[index] = SetCard.Property.one
            } else if cardOne.properties[index].rawValue + cardTwo.properties[index].rawValue == 2 {
                propertyValues[index] = SetCard.Property.two
            } else {
                propertyValues[index] = SetCard.Property.three
            }
        }
        return SetCard(number: propertyValues[0]!, shape: propertyValues[1]!, color: propertyValues[2]!, shading: propertyValues[3]!)
    }
    
    private mutating func checkMatch(_ cards: Set<SetCard>) -> Bool {
        if cards.count != 3 {
            return false
        }
        let sortedCards = cards.sorted(by: <)
        for index in 0..<4 {
            if sortedCards[0].properties[index] == sortedCards[1].properties[index] {
                if sortedCards[2].properties[index] != sortedCards[0].properties[index] {
                    score -= 5
                    return false
                }
            } else {
                if sortedCards[2].properties[index] == sortedCards[0].properties[index] || sortedCards[2].properties[index] == sortedCards[1].properties[index] {
                    score -= 5
                    return false
                }
            }
        }
        score += 3
        if -timeSinceLastFoundSet.timeIntervalSinceNow < 5.0 {
            score += 2
        }
        timeSinceLastFoundSet = Date()
        return true
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return self
        }
    }
}

