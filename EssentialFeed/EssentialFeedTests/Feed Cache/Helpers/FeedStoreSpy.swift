//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 18/4/2565 BE.
//

import Foundation
import EssentialFeed

final class FeedStoreSpy: FeedStore {
    
    enum ReceivedMessage: Equatable {
        case deletion
        case insertion([LocalFeedImage], Date)
        case retrieve
    }
    
    private(set) var receivedMessages: [ReceivedMessage] = []
    private var deletetionCompletions: [DeletionCompletion] = []
    private var insertionCompletions: [InsertionCompletion] = []
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deletetionCompletions.append(completion)
        receivedMessages.append(.deletion)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletetionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletetionCompletions[index](nil)
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping (InsertionCompletion)) {
        receivedMessages.append(.insertion(feed, timestamp))
        insertionCompletions.append(completion)
    }
    
    func retrieve() {
        receivedMessages.append(.retrieve)
    }
}
