//
//  AnyShape.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct AnyShape: Shape {
  private let _path: (CGRect) -> Path
  
  init<S: Shape>(_ wrapped: S) {
    _path = { rect in
      return wrapped.path(in: rect)
    }
  }
  
  func path(in rect: CGRect) -> Path {
    return _path(rect)
  }
}
