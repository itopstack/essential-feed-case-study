//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import XCTest

final class RemoteFeedLoader {
     
}

final class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func testInitDoesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
