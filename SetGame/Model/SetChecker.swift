//
//  SetChecker.swift
//  SetGame
//
//  Created by Igor Blinnikov on 18.12.2021.
//

import Foundation

struct SetChecker {
  // TODO: Cover with UTs
  static func checkCardsForSet(first: Card, second: Card, third: Card) -> Bool {
    return (
      areAllCardsWithTheSameNumberOfShapes(first: first, second: second, third: third)
      || areAllCardsWithDifferentNumberOfShapes(first: first, second: second, third: third)
    )
    && (
      areAllCardsWithTheSameColor(first: first, second: second, third: third)
      || areAllCardsWithDifferentColor(first: first, second: second, third: third)
    )
    && (
      areAllCardsWithTheSameShape(first: first, second: second, third: third)
      || areAllCardsWithDifferentShape(first: first, second: second, third: third)
    )
    && (
      areAllCardsWithTheSameShading(first: first, second: second, third: third)
      || areAllCardsWithDifferentShading(first: first, second: second, third: third)
    )
  }
  
  // Number of Shapes
  private static func areAllCardsWithTheSameNumberOfShapes(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithTheSameFeature(first: first, second: second, third: third, feature: \.numberOfShapes)
  }
  
  private static func areAllCardsWithDifferentNumberOfShapes(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithDifferentFeature(first: first, second: second, third: third, feature: \.numberOfShapes)
  }
  
  // Color
  private static func areAllCardsWithTheSameColor(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithTheSameFeature(first: first, second: second, third: third, feature: \.color)
  }
  
  private static func areAllCardsWithDifferentColor(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithDifferentFeature(first: first, second: second, third: third, feature: \.color)
  }
  
  // Shape
  private static func areAllCardsWithTheSameShape(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithTheSameFeature(first: first, second: second, third: third, feature: \.shape)
  }
  
  private static func areAllCardsWithDifferentShape(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithDifferentFeature(first: first, second: second, third: third, feature: \.shape)
  }
  
  // Shading
  private static func areAllCardsWithTheSameShading(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithTheSameFeature(first: first, second: second, third: third, feature: \.shading)
  }
  
  private static func areAllCardsWithDifferentShading(first: Card, second: Card, third: Card) -> Bool {
    return areAllCardsWithDifferentFeature(first: first, second: second, third: third, feature: \.shading)
  }
  
  // Base comparisons
  private static func areAllCardsWithTheSameFeature<Feature: Equatable>(first: Card, second: Card, third: Card, feature: KeyPath<Card, Feature>) -> Bool {
    return first[keyPath: feature] == second[keyPath: feature] && first[keyPath: feature] == third[keyPath: feature];
  }
  
  private static func areAllCardsWithDifferentFeature<Feature: Equatable>(first: Card, second: Card, third: Card, feature: KeyPath<Card, Feature>) -> Bool {
    return first[keyPath: feature] != second[keyPath: feature]
      && first[keyPath: feature] != third[keyPath: feature]
      && second[keyPath: feature] != third[keyPath: feature];
  }
}
