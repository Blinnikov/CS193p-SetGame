//
//  CardView.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct CardView: View {
  let card: Card
  @State private var selected = false
  
  var body: some View {
    
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 10)
      shape.fill()
      if selected {
        shape.strokeBorder(.blue, lineWidth: 4)
      } else {
        shape.strokeBorder(.gray, lineWidth: 1.5)
      }

      content(for: card)
        .padding()
        .foregroundColor(.fromCardColor(card.color))
    }
    .foregroundColor(.white)
    .onTapGesture {
      print("Selected pressed. Its value: \(selected)")
      selected.toggle()
    }
  }
  
  @ViewBuilder
  func content(for card: Card) -> some View {
    VStack {
      Spacer()
      ForEach(0..<card.numberOfShapes, id: \.self) { _ in
        figure(for: card)
          .aspectRatio(2, contentMode: .fit)
        Spacer()
      }
    }
  }
  
  @ViewBuilder
  func figure(for card: Card) -> some View {
    switch card.shading {
    case .open:
      shape(for: card).stroke(lineWidth: 2)
    case .solid:
      shape(for: card).fill()
    case .striped:
      let shape = shape(for: card)
      ZStack {
        shape.stroke(lineWidth: 2)
        shape.fill().opacity(0.5)
      }
    }
  }
  
  func shape(for card: Card) -> some Shape {
    switch card.shape {
    case .squiggle:
      return AnyShape(Rectangle())
    case .diamond:
      return AnyShape(Diamond())
    case .oval:
      return AnyShape(RoundedRectangle(cornerRadius: .infinity))
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = Card(numberOfShapes: 3, shape: .diamond, shading: .open, color: .purple)
    CardView(card: card)
  }
}
