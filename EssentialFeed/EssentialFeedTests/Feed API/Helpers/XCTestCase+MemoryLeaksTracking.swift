//
//  XCTestCase+MemoryLeaksTracking.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 11/4/2565 BE.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
