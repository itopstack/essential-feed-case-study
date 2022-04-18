//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 16/4/2565 BE.
//

import Foundation

public enum RetrievalCachedFeedResult {
    case empty
    case failure(Error)
    case found(feed: [LocalFeedImage], timestamp: Date)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrievalCachedFeedResult) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping (InsertionCompletion))
    func retrieve(completion: @escaping RetrievalCompletion)
}
