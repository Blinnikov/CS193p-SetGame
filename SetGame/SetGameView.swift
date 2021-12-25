//
//  ContentView.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var viewModel: SetViewModel
  
  @Namespace private var setNamespace
  
  init(viewModel: SetViewModel) {
    self.viewModel = viewModel
  }
  
  func matchAnimation(isMatched: Bool?) -> Animation? {
    if isMatched == nil {
      return nil
    }
    
    return .spring(response: 0.7, dampingFraction: 0.1)
  }
  
  func rotationDegreesForDiscardedCard(_ card: Card) -> Angle {
    let degree = Double(card.id.uuidString.hash % 21 - 10) // -10...10
    return .degrees(degree)
  }
  
  var body: some View {
    VStack {
      HStack {
        deck
        Spacer()
        discardPile
      }
      
      AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: setNamespace)
          .scaleEffect(card.isPartOfASet != nil && card.isPartOfASet! ? 1.05 : 1.0)
          .animation(matchAnimation(isMatched: card.isPartOfASet), value: card.isPartOfASet)
          .padding(4)
          .onTapGesture {
            withAnimation {
              viewModel.choose(card)
            }
          }
      }
      .zIndex(-100) // Need to check whether it's what we need

      Button {
        viewModel.startNewGame()
      } label: {
        Text("Start New Game")
      }
    }
    .padding(.horizontal)
    
  }
  
  var deck: some View {
    VStack(alignment: .leading) {
      if viewModel.deck.isEmpty {
        emptyPile
      }
      else {
        ZStack {
          ForEach(viewModel.deck) { card in
            CardView(card: card)
              .matchedGeometryEffect(id: card.id, in: setNamespace)
              .frame(width: CardConstants.DeckCardWidth, height: CardConstants.DeckCardHeight)
          }
        }
        .onTapGesture {
          withAnimation {
            viewModel.laidOutMoreCards()
          }
        }
      }
      Text("Deck: \(viewModel.deck.count)")
    }
  }
  
  var discardPile: some View {
    VStack(alignment: .trailing) {
      if viewModel.discardPile.isEmpty {
        emptyPile
      } else {
        ZStack {
          ForEach(viewModel.discardPile) { card in
            CardView(card: card)
              .matchedGeometryEffect(id: card.id, in: setNamespace)
              .rotationEffect(rotationDegreesForDiscardedCard(card))
              .frame(width: CardConstants.DeckCardWidth, height: CardConstants.DeckCardHeight)
          }
        }
      }
      Text("Discarded: \(viewModel.discardPile.count)")
    }
  }
  
  var emptyPile: some View {
    RoundedRectangle(cornerRadius: 10)
      .foregroundColor(.gray)
      .opacity(0.2)
      .frame(width: CardConstants.DeckCardWidth, height: CardConstants.DeckCardHeight)
  }
  
  private struct CardConstants {
    static var DeckCardWidth: CGFloat = 60
    static var DeckCardHeight: CGFloat = 90
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = SetViewModel()
    SetGameView(viewModel: game)
  }
}
