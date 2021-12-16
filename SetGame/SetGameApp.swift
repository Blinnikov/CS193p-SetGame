//
//  SetGameApp.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

@main
struct SetGameApp: App {
  private let game = SetViewModel()
  var body: some Scene {
    WindowGroup {
      SetGameView(viewModel: game)
    }
  }
}
