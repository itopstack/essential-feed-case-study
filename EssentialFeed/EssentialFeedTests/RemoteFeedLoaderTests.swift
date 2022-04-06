//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import XCTest

final class RemoteFeedLoader {
     
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

final class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func testInitDoesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func testLoadRequestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
