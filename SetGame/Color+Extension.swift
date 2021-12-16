//
//  Color+Extension.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

extension Color {
  static func fromCardColor(_ color: Card.Color) -> Color {
    switch color {
    case .red:
      return .red
    case .green:
      return .green
    case .purple:
      return .purple
    }
  }
}
