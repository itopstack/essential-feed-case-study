//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 16/4/2565 BE.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping (InsertionCompletion))
    func retrieve(completion: @escaping RetrievalCompletion)
}
