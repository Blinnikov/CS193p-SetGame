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
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)]) {
        ForEach(viewModel.cards) { card in
          CardView(card: card)
            .aspectRatio(2/3, contentMode: .fit)
            .padding(4)
        }
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
