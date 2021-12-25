//
//  Cardify.swift
//  SetGame
//
//  Created by Igor Blinnikov on 26.12.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  var rotation: Double
  var isSelected: Bool
  
  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }
  
  init(isFaceUp: Bool, isSelected: Bool) {
    self.rotation = isFaceUp ? 0 : 180
    self.isSelected = isSelected
  }
  
  func body(content: Content) -> some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 10)
      if rotation < 90 { // isFaceUp
        shape.fill()
        if isSelected {
          shape.strokeBorder(.blue, lineWidth: 2.5)
        } else {
          shape.strokeBorder(.gray, lineWidth: 1.5)
        }
        
        content
      } else {
        shape.fill().foregroundColor(.red)
      }
    }
    .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
  }
}

extension View {
  func cardify(isFaceUp: Bool, isSelected: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected))
  }
}
