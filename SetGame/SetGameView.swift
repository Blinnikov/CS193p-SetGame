//
//  ContentView.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var viewModel: SetViewModel
  
  init(viewModel: SetViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button {
          viewModel.laidOutMoreCards()
        } label: {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("3 more cards")
        }
      }
      
      AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
        CardView(card: card)
          .padding(4)
      }

      Button {
        viewModel.startNewGame()
      } label: {
        Text("Start New Game")
      }
    }
    .padding(.horizontal)
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = SetViewModel()
    SetGameView(viewModel: game)
  }
}
