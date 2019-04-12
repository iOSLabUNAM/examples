//
//  AcelerometerTests.swift
//  AcelerometerTests
//
//  Created by Luis Ezcurdia on 5/1/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Acelerometer

class CentralTendencyCalculatorTests: XCTestCase {
    func testAVG() {
        let calculator = CentralTendencyCalculator()
        for val in (1...10) {
            calculator.append(Double(val))
        }
        XCTAssertEqual(5.5, calculator.avg())
        XCTAssertEqual(1.0, calculator.min)
        XCTAssertEqual(10.0, calculator.max)
    }

    func testPerformanceExample() {
        let calculator = CentralTendencyCalculator()
        for _ in (1...1000) {
            calculator.append(Double(arc4random_uniform(100)))
        }
        self.measure {
            XCTAssertEqual(50.0, calculator.avg(), accuracy: 3.0)
        }
    }
}
