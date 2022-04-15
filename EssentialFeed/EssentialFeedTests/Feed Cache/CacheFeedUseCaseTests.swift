//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 15/4/2565 BE.
//

import XCTest

final class LocalFeedLoader {
    
    init(store: FeedStore) {
        
    }
}

final class FeedStore {
    
    var deleteCachedFeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func testInitDoesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
}
