//
//  SetCard.swift
//  Set
//
//  Created by Stephen  on 2/5/18.
//  Copyright © 2018 Stephen . All rights reserved.
//

import Foundation

struct SetCard: Hashable {
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func <(lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.identifier < rhs.identifier
    }
    
    enum Property: Int {
        case one
        case two
        case three
    }
    
    let number: Property
    let shape: Property
    let color: Property
    let shading: Property
    let identifier: Int
    let properties: [Property]
    
    init?(id: Int) {
        if id < 0 || id > 80 {
            return nil
        }
        identifier = id
        var tmp = id
        number = Property(rawValue: tmp % 3)!
        tmp /= 3
        shape = Property(rawValue: tmp % 3)!
        tmp /= 3
        color = Property(rawValue: tmp % 3)!
        tmp /= 3
        shading = Property(rawValue: tmp % 3)!
        properties = [number, shape, color, shading]
    }
    
    init(number: Property, shape: Property, color: Property, shading: Property) {
        self.number = number
        self.shape = shape
        self.color = color
        self.shading = shading
        self.identifier = number.rawValue + (shape.rawValue * 3) + (color.rawValue * 9) + (shading.rawValue * 27)
        self.properties = [number, shape, color, shading]
    }
    
    static var allCards: Set<SetCard> {
        var cards = Set<SetCard>()
        for id in 0..<81 {
            cards.insert(SetCard(id: id)!)
        }
        return cards
    }
}
