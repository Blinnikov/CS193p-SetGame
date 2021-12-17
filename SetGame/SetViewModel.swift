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
  
  func startNewGame() {
    self.model = SetViewModel.createSetGame()
  }
  
  func laidOutMoreCards() {
    self.model.laidOutNextCards(3)
  }
  
  private static func createSetGame() -> SetGame {
    let deck = createDeck()
    return SetGame(cards: deck)
  }
  
  private static func createDeck() -> [Card] {
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
  
  // MARK: - Intent(s)
  func choose(_ card: Card) {
    model.choose(card)
  }
}
