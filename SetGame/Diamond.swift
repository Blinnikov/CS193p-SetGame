//
//  Diamond.swift
//  SetGame
//
//  Created by Igor Blinnikov on 16.12.2021.
//

import SwiftUI

struct Diamond: Shape {
  func path(in rect: CGRect) -> Path {
    let topVertex = CGPoint(x: rect.midX, y: rect.minY)
    let leadingVertex = CGPoint(x: rect.minX, y: rect.midY)
    let bottomVertex = CGPoint(x: rect.midX, y: rect.maxY)
    let trailingVertex = CGPoint(x: rect.maxX, y: rect.midY)
    
    var p = Path()
    p.move(to: topVertex)
    p.addLine(to: leadingVertex)
    p.addLine(to: bottomVertex)
    p.addLine(to: trailingVertex)
    p.addLine(to: topVertex)
    return p
  }
}
