//
//  SetGameTests.swift
//  SetGameTests
//
//  Created by Igor Blinnikov on 18.12.2021.
//

import XCTest
@testable import SetGame

class SetGameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
  
  func testForSet1() {
    let firstCard = Card(numberOfShapes: 1, shape: .diamond, shading: .open, color: .green)
    let secondCard = Card(numberOfShapes: 2, shape: .squiggle, shading: .striped, color: .purple)
    let thirdCard = Card(numberOfShapes: 3, shape: .oval, shading: .solid, color: .red)
    
    let isSet = SetChecker.checkCardsForSet(first: firstCard, second: secondCard, third: thirdCard)
    XCTAssertTrue(isSet)
  }
  
  func testForSet2() {
    let firstCard = Card(numberOfShapes: 3, shape: .diamond, shading: .solid, color: .red)
    let secondCard = Card(numberOfShapes: 2, shape: .squiggle, shading: .solid, color: .green)
    let thirdCard = Card(numberOfShapes: 1, shape: .oval, shading: .solid, color: .purple)
    
    let isSet = SetChecker.checkCardsForSet(first: firstCard, second: secondCard, third: thirdCard)
    XCTAssertTrue(isSet)
  }
  
  func testForSet3() {
    let firstCard = Card(numberOfShapes: 3, shape: .diamond, shading: .solid, color: .red)
    let secondCard = Card(numberOfShapes: 2, shape: .squiggle, shading: .solid, color: .red)
    let thirdCard = Card(numberOfShapes: 1, shape: .oval, shading: .solid, color: .purple)
    
    let isSet = SetChecker.checkCardsForSet(first: firstCard, second: secondCard, third: thirdCard)
    XCTAssertFalse(isSet)
  }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
