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
  private var chosenIndices: [Int] = []
  
  // MARK: - temporary vars
  private var isSet = true
  
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
    
    print("Cards left: \(deck.count)")
  }
  
  mutating func swapCardsIn(indices: [Int]) {
    for index in indices {
      guard let card = self.deck.popLast() else {
        break
      }
      
      self.laidOutCards[index] = card
    }
  }
  
  mutating func choose(_ card: Card) {
    guard let chosenIndex = laidOutCards.firstIndex(where: { $0.id == card.id}) else {
      return
    }
    
    if chosenIndices.count == 3 {
      if isSet {
        // Increment Sets counter
        // Deal 3 new cards
        for index in chosenIndices.sorted(by: { $0 > $1}) {
          print(index)
          guard let card = self.deck.popLast() else {
            laidOutCards.remove(at: index)
            continue
          }
          laidOutCards[index] = card
        }
        // Empty selection
        chosenIndices = []
        // Select that card if not part of the set
      } else {
        // Empty selection
        for index in laidOutCards.indices {
          laidOutCards[index].selected = false
        }
        chosenIndices = []
        // Select that card
        selectCard(at: chosenIndex)
        return
      }
    }
    
    if card.selected {
      // remove from chosenIndices
      deselectCard(at: chosenIndex)
    } else {
      // add to chosenIndices
      selectCard(at: chosenIndex)
    }
    
    print(chosenIndices)
  }
  
  mutating func selectCard(at index: Int) {
    chosenIndices.append(index)
    laidOutCards[index].selected = true
  }
  
  mutating func deselectCard(at index: Int) {
    chosenIndices.removeAll(where: { $0 == index })
    laidOutCards[index].selected = false
  }
}

struct Card: Identifiable {
  let id = UUID()
  let numberOfShapes: Int
  let shape: Shape
  let shading: Shading
  let color: Color
  var selected = false
  
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
