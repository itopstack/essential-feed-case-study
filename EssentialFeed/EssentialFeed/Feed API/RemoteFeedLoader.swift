//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 7/4/2565 BE.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
     
    private let client: HTTPClient
    private let url: URL
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }
}
