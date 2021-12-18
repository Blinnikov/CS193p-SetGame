//
//  CardView.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct CardView: View {
  let card: Card
  
  var body: some View {
    
    GeometryReader { geometryProxy in
      ZStack {
        let shape = RoundedRectangle(cornerRadius: 10)
        shape.fill()
        if card.selected {
          shape.strokeBorder(.blue, lineWidth: 4)
        } else {
          shape.strokeBorder(.gray, lineWidth: 1.5)
        }

        content(for: card)
          .padding(paddingForCard(width: geometryProxy.size.width))
          .foregroundColor(.fromCardColor(card.color))
      }
      .foregroundColor(foregroundColorFor(card: card))
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
  
  func paddingForCard(width: CGFloat) -> CGFloat {
    switch width {
    case 0...60:
      return 4
    case 61...80:
      return 8
    case 81...100:
      return 12
    default:
      return 16
    }
  }
  
  func foregroundColorFor(card: Card) -> Color {
    if let isPartOfASet = card.isPartOfASet {
      let color = isPartOfASet ? Color.yellow : .gray
      return color.opacity(0.2)
    }
    
    return .white
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = Card(numberOfShapes: 3, shape: .diamond, shading: .open, color: .purple)
    CardView(card: card)
      .aspectRatio(2/3, contentMode: .fit)
      .frame(width: 40)
  }
}
