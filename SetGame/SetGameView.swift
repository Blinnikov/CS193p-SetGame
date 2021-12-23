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
    VStack {
      if viewModel.deck.isEmpty {
        emptyPile
      }
      else {
        ZStack {
          ForEach(viewModel.deck) { card in
            CardView(card: card, isFaceUp: false)
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
    VStack {
      if viewModel.discardPile.isEmpty {
        emptyPile
      } else {
        ZStack {
          ForEach(viewModel.discardPile) { card in
            CardView(card: card)
              .matchedGeometryEffect(id: card.id, in: setNamespace)
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
