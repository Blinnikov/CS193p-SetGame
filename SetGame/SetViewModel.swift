//
//  SetViewModel.swift
//  SetGame
//
//  Created by Igor Blinnikov on 17.12.2021.
//

import Foundation

class SetViewModel: ObservableObject {
  @Published private var model = createSetGame()
  
  var cards: [Card] {
    model.laidOutCards
  }
  
  var deck: [Card] {
    model.fullDeck
  }
  
  var discardPile: [Card] {
    model.discardPile
  }
  
  func startNewGame() {
    self.model = SetViewModel.createSetGame()
  }
  
  func laidOutMoreCards() {
    self.model.laidOutMoreCards()
  }
  
  private static func createSetGame() -> SetGame {
    let deck = createDeck()
    return SetGame(cards: deck)
  }
  
  private static func createDeck() -> [Card] {
    let deck = createBasicNonShuffledDeck()
    return shuffleCardsAndUpdateIndices(for: deck)
  }
  
  private static func createBasicNonShuffledDeck() -> [Card] {
    var deck: [Card] = []
    
    for number in 1...3 {
      for shape in Card.Shape.allCases {
        for shading in Card.Shading.allCases {
          for color in Card.Color.allCases {
            let card = Card(numberOfShapes: number, shape: shape, shading: shading, color: color)
            deck.append(card)
          }
        }
      }
    }
    
    return deck
  }
  
  private static func shuffleCardsAndUpdateIndices(for deck: [Card]) -> [Card] {
    var result: [Card] = []
    var index = 0
    
    for var card in deck.shuffled() {
      index += 1
      card.orderInDeck = index
      result.append(card)
    }
    
    return result
  }
  
  // MARK: - Intent(s)
  func choose(_ card: Card) {
    model.choose(card)
  }
}
