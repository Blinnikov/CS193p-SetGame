//
//  ContentView.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var viewModel: SetViewModel
  @State private var dealt = Set<UUID>()
  
  @Namespace private var setNamespace
  
  init(viewModel: SetViewModel) {
    self.viewModel = viewModel
  }
  
  private func deal(_ card: Card) {
    dealt.insert(card.id)
  }
  
  private func isUndealt(_ card: Card) -> Bool {
    !dealt.contains(card.id)
  }
  
  func matchAnimation(isMatched: Bool?) -> Animation? {
    if isMatched == nil {
      return nil
    }
    
    return .spring(response: 0.7, dampingFraction: 0.1)
  }
  
  private func zIndex(of card: Card, isInDeck: Bool = false) -> Double {
    isInDeck
      ? Double(card.orderInDeck)
      : 81 - Double(card.orderInDeck)
  }
  
  func rotationDegreesForDiscardedCard(_ card: Card) -> Angle {
    let degree = Double(card.id.uuidString.hash % 21 - 10) // -10...10
    return .degrees(degree)
  }
  
  private func dealWithAnimation() {
    let DealAnimationDuration: CGFloat = 0.3
    let FlipOverAnimationDuration: CGFloat = 0.2
    let CardDealDelay: CGFloat = 0.2
    let FlipOverDelay: CGFloat = 0.2
    
    var cardDelay = CardDealDelay
    for card in viewModel.laidOutMoreCards() {
      withAnimation(Animation.easeInOut(duration: DealAnimationDuration).delay(cardDelay)) {
        deal(card)
      }
      
      withAnimation(Animation.easeIn(duration: FlipOverAnimationDuration).delay(cardDelay + FlipOverDelay)) {
        viewModel.flipOver(card)
      }
      
      cardDelay += CardDealDelay
    }
  }
  
  var body: some View {
    VStack {
      AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
        let z = zIndex(of: card)
        
        if isUndealt(card) {
          Color.clear
        } else {
          CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: setNamespace)
            .scaleEffect(card.isPartOfASet != nil && card.isPartOfASet! ? 1.05 : 1.0)
            .animation(matchAnimation(isMatched: card.isPartOfASet), value: card.isPartOfASet)
            .padding(4)
            .zIndex(z)
            .onTapGesture {
              withAnimation {
                viewModel.choose(card)
              }
          }
        }
      }
      .onAppear {
        dealWithAnimation()
      }
      
      HStack {
        deck
        Spacer()
        discardPile
      }

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
          ForEach(viewModel.deck.filter(isUndealt)) { card in
            let z = zIndex(of: card, isInDeck: true)
            CardView(card: card)
              .matchedGeometryEffect(id: card.id, in: setNamespace)
              .zIndex(z)
              .frame(width: CardConstants.DeckCardWidth, height: CardConstants.DeckCardHeight)
          }
        }
        .onTapGesture {
          dealWithAnimation()
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
