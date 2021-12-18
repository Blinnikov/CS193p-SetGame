//
//  SetGame.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import Foundation

struct SetGame {
  private(set) var deck: [Card]
  private(set) var laidOutCards: [Card] = []
  private var chosenIndices: [Int] = []
  private(set) var numberOfSets = 0
  
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
    
    // We're choosing 4th card
    // Let's deal next 3 cards
    if chosenIndices.count == 3 {
      // TODO: We can probe for a set here by checling `isPartOfASet` property
      if isSet(indices: chosenIndices) {
        // Increment Sets counter
        // - We incremented it on 3d card selection, but here is also a place.
        // Deal 3 new cards
        for index in chosenIndices.sorted(by: { $0 > $1}) {
          print(index)
          guard let card = self.deck.popLast() else {
            // BUG: We cannot mutate collection here because `chosenIndex` is set and it will be wrong after the loop
            // Either mark card with a tombstone or make it nullable
            laidOutCards.remove(at: index)
            continue
          }
          laidOutCards[index] = card
        }
        // Empty selection
        chosenIndices = []
        // Select that card if not part of the set
      } else {
        // Mark as having no set
        // TODO: Probably extract as a separate method
        markCards(atIndices: chosenIndices, asHavingSet: nil)
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
    
    // We've already selected 3 cards
    // Check them for set
    if chosenIndices.count == 3 {
      if isSet(indices: chosenIndices) {
        markCards(atIndices: chosenIndices, asHavingSet: true)
        // Increment Sets counter
        numberOfSets += 1
      } else {
        markCards(atIndices: chosenIndices, asHavingSet: false)
      }
    }
    
    print(chosenIndices)
  }
  
  private func isSet(indices: [Int]) -> Bool {
    guard indices.count == 3 else {
      print("We need to have exactly 3 cards to check for set")
      return false
    }
    
    let firstCard = laidOutCards[indices[0]]
    let secondCard = laidOutCards[indices[1]]
    let thirdCard = laidOutCards[indices[2]]
    
    return SetChecker.checkCardsForSet(first: firstCard, second: secondCard, third: thirdCard)
  }
  
  private mutating func markCards(atIndices indices: [Int], asHavingSet: Bool?) {
    for index in indices {
      laidOutCards[index].isPartOfASet = asHavingSet
    }
  }
  
  private mutating func selectCard(at index: Int) {
    chosenIndices.append(index)
    laidOutCards[index].selected = true
  }
  
  private mutating func deselectCard(at index: Int) {
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
  var isPartOfASet: Bool?
  
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
