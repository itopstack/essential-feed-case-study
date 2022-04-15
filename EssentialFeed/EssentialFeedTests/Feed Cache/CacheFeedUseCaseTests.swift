//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 15/4/2565 BE.
//

import XCTest
import EssentialFeed

final class LocalFeedLoader {
    
    private let store: FeedStore
    private let currentDate: () -> Date
    
    init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed { [unowned self] error in
            if error == nil {
                self.store.insert(items, timestamp: currentDate())
            }
        }
    }
}

final class FeedStore {
    
    typealias DeletionCompletion = (Error?) -> Void
    
    enum ReceivedMessage: Equatable {
        case deletion
        case insertion([FeedItem], Date)
    }
    
    private(set) var receivedMessages: [ReceivedMessage] = []
    private var deletetionCompletions: [DeletionCompletion] = []
    
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
    
    func insert(_ items: [FeedItem], timestamp: Date) {
        receivedMessages.append(.insertion(items, timestamp))
    }
}

final class CacheFeedUseCaseTests: XCTestCase {

    func testInitDoesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func testSaveRequestCacheDeletion() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items)
        
        XCTAssertEqual(store.receivedMessages, [.deletion])
    }
    
    func testSaveDoesNotRequestCacheInsertionOnDeletionError() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        sut.save(items)
        store.completeDeletion(with: deletionError)
        
        XCTAssertEqual(store.receivedMessages, [.deletion])
    }
    
    func testSaveRequestNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        sut.save(items)
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.receivedMessages, [.deletion, .insertion(items, timestamp)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(instance: store, file: file, line: line)
        trackForMemoryLeaks(instance: sut, file: file, line: line)
        return (sut, store)
    }
    
    private func uniqueItem() -> FeedItem {
        FeedItem(id: UUID(), description: nil, location: nil, imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
    
    private func anyNSError() -> NSError {
        NSError(domain: "any error", code: 0)
    }
}
