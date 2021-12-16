//
//  SetGame.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import Foundation

struct SetGame {
  private var deck: [Card]
  private(set) var laidOutCards: [Card] = []
  
  init(cards: [Card]) {
    self.deck = cards.shuffled()
    
    self.laidOutNextCards(12)
  }
  
  mutating func laidOutNextCards(_ amount: Int) {
    for _ in 0..<amount {
      guard let card = self.deck.popLast() else {
        break
      }
      
      self.laidOutCards.append(card)
    }
  }
  
  mutating func swapCardsIn(indices: [Int]) {
    for index in indices {
      guard let card = self.deck.popLast() else {
        break
      }
      
      self.laidOutCards[index] = card
    }
  }
}

struct Card: Identifiable {
  let numberOfShapes: Int
  let shape: Shape
  let shading: Shading
  let color: Color
  let id = UUID()
  
  enum Shape: CaseIterable {
    case diamond
    case squiggle
    case oval
  }

  enum Shading: CaseIterable {
    case solid
    case striped
    case open
  }
  
  enum Color: CaseIterable {
    case red
    case green
    case purple
  }
}
