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
  private(set) var discardPile: [Card] = []
  private var chosenIndices: [Int] = []
  
  init(cards: [Card]) {
    self.deck = cards
    
    self.laidOutNextCards(12)
  }
  
  mutating func laidOutMoreCards() {
    defer { print("Cards left: \(deck.count)") }
    
    if isSet(indices: chosenIndices) {
      replaceCards(at: chosenIndices)
    } else {
      laidOutNextCards(3)
    }
  }
  
  mutating func choose(_ card: Card) {
    guard var chosenIndex = laidOutCards.firstIndex(where: { $0.id == card.id}) else {
      return
    }
    
    // We're choosing 4th card
    // Let's deal next 3 cards
    if chosenIndices.count == 3 {
      // TODO: We can probe for a set here by checling `isPartOfASet` property
      if isSet(indices: chosenIndices) {
        // Increment Sets counter
        // - We incremented it on 3d card selection, but here is also a place.
        
        let newChosenIndex = calculateNewChosenIndex(chosenIndex, for: chosenIndices)
        discardCards(at: chosenIndices)
        chosenIndices = []
        
        if let newChosenIndex = newChosenIndex {
          chosenIndex = newChosenIndex
        } else {
          return
        }
        
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
  
  private mutating func laidOutNextCards(_ amount: Int) {
    for _ in 0..<amount {
//      guard let card = self.deck.popLast() else {
//        break
//      }
      
      if self.deck.isEmpty {
        break
      }
      
      var card = self.deck.removeFirst()
//      card.isFaceUp = true
      self.laidOutCards.append(card)
    }
  }
  
  private mutating func discardCards(at indices: [Int]) {
    for index in indices.sorted(by: { $0 > $1}) {
      moveCardToDiscardPile(from: index)
    }
  }
  
  private mutating func replaceCards(at indices: [Int]) {
    for index in indices {
      guard let card = self.deck.popLast() else {
        continue
      }
      moveCardToDiscardPile(from: index, withReplacement: card)
    }
  }
  
  private func calculateNewChosenIndex(_ chosenIndex: Int, for indices: [Int]) -> Int? {
    var step = 0
    for index in indices {
      if chosenIndex == index {
        return nil
      }
      if chosenIndex > index {
        step += 1
      }
    }
    return chosenIndex - step
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
  
  // MARK: - Assignment 4
  private mutating func moveCardToDiscardPile(from index: Int, withReplacement card: Card? = nil) {
    // Add to discard pile
    laidOutCards[index].isPartOfASet = nil
    laidOutCards[index].selected = false
    discardPile.append(laidOutCards[index])
    
    if let card = card {
      // Replace with a new one
      laidOutCards[index] = card
    } else {
      // Remove from laid out cards
      laidOutCards.remove(at: index)
    }
  }
}

struct Card: Identifiable {
  let id = UUID()
  let numberOfShapes: Int
  let shape: Shape
  let shading: Shading
  let color: Color
  var index: Int = -1
  var selected = false
  var isFaceUp = false
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
