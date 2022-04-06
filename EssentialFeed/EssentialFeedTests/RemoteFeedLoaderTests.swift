//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import XCTest

final class RemoteFeedLoader {
     
    private let client: HTTPClient
    private let url: URL
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func testInitDoesNotRequestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client, url: url)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func testLoadRequestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client, url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
}
