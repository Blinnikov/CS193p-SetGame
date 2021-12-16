//
//  SetGame.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import Foundation

struct SetGame {
  private(set) var cards: [Card]
}

struct Card {
  let numberOfShapes: Int
  let shape: Shape
  let shading: Shading
  let color: Color
  
  enum Shape {
    case diamond
    case squiggle
    case oval
  }

  enum Shading {
    case solid
    case striped
    case open
  }
  
  enum Color {
    case red
    case green
    case purple
  }
}
