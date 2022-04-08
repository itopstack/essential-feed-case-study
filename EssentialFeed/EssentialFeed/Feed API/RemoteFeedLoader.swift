//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 7/4/2565 BE.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
     
    private let client: HTTPClient
    private let url: URL
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success(let httpURLResponse):
                completion(.invalidData)
            case .failure(let error):
                completion(.connectivity)
            }
        }
    }
}
