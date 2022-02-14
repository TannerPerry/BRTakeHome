//
//  TestUtils.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import XCTest

public extension XCTestCase {
    func waitForBooleanExpectation(timeout: TimeInterval, condition: @escaping () -> Bool) {
        let expectation = self.expectation(description: "Waiting for boolean expectation")
        var elapsedTime: TimeInterval = 0
        let timerInterval: TimeInterval = 0.02
        var conditionMet = false
        
        let timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            elapsedTime += timerInterval
            
            conditionMet = condition()
            if elapsedTime >= timeout || conditionMet {
                timer.invalidate()
                expectation.fulfill()
            }
        }
        
        DispatchQueue.main.async {
            if timer.isValid {
                timer.fire()
            }
        }
        
        wait(for: [expectation], timeout: timeout+10)
        
        if !conditionMet {
            XCTFail("Failed to meet condition before timeout.")
        }
    }
}
