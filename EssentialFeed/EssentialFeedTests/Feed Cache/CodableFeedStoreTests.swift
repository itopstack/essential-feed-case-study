//
//  CodableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 23/4/2565 BE.
//

import XCTest
import EssentialFeed

final class CodableFeedStore {
    
    private struct Cache: Codable {
        let feed: [CodablaFeedImage]
        let timestamp: Date
        
        var localFeed: [LocalFeedImage] {
            feed.map { $0.local }
        }
    }
    
    private struct CodablaFeedImage: Codable {
        private let id: UUID
        private let description: String?
        private let location: String?
        private let url: URL
        
        var local: LocalFeedImage {
            LocalFeedImage(id: id, description: description, location: location, url: url)
        }
        
        init(localFeedImage: LocalFeedImage) {
            self.id = localFeedImage.id
            self.description = localFeedImage.description
            self.location = localFeedImage.location
            self.url = localFeedImage.url
        }
    }
    
    private let storeURL: URL
    
    init(storeURL: URL) {
        self.storeURL = storeURL
    }
    
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
        
        let decoder = JSONDecoder()
        let cache = try! decoder.decode(Cache.self, from: data)
        completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping (FeedStore.InsertionCompletion)) {
        let encoder = JSONEncoder()
        let cache = Cache(feed: feed.map(CodablaFeedImage.init), timestamp: timestamp)
        let encoded = try! encoder.encode(cache)
        try! encoded.write(to: storeURL)
        completion(nil)
    }
}

final class CodableFeedStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }

    func test_retrive_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toCompleteWith: .empty)
    }
    
    func test_retrive_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { firstResult in
            sut.retrieve { secondResult in
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                    
                default:
                    XCTFail("Expected retriveing twice from empty cache to deliver same empty result, got \(firstResult) and \(secondResult) instead")
                }
                
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_retriveAfterInsertingToEmptyCache_deliversInsertedValues() {
        let sut = makeSUT()
        let feed = uniqueFeedImages().locals
        let timestamp = Date()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.insert(feed, timestamp: timestamp) { insertionError in
            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        expect(sut, toCompleteWith: .found(feed: feed, timestamp: timestamp))
    }
    
    func test_retrive_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        let feed = uniqueFeedImages().locals
        let timestamp = Date()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.insert(feed, timestamp: timestamp) { insertionError in
            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")
            
            sut.retrieve { firstResult in
                sut.retrieve { secondResult in
                    switch (firstResult, secondResult) {
                    case let (.found(firstFeed, firstTimestamp), .found(secondFeed, secondTimestamp)):
                        XCTAssertEqual(firstFeed, feed)
                        XCTAssertEqual(firstTimestamp, timestamp)
                        XCTAssertEqual(secondFeed, feed)
                        XCTAssertEqual(secondTimestamp, timestamp)
                        
                    default:
                        XCTFail("Expected retrieving twice from non empty cache to deliver same found result with feed \(feed) and timestamp \(timestamp), got \(firstResult) and \(secondResult) instead")
                    }
                    
                    exp.fulfill()
                }
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> CodableFeedStore {
        let sut = CodableFeedStore(storeURL: testSpecificStoreURL())
        trackForMemoryLeaks(instance: sut, file: file, line: line)
        return sut
    }
    
    private func expect(_ sut: CodableFeedStore, toCompleteWith expectedResult: RetrievalCachedFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { receivedResult in
            switch (receivedResult, expectedResult) {
            case (.empty, .empty):
                break
                
            case let (.found(receivedFeed, receivedTimestamp), (.found(feed: expectedFeed, timestamp: expectedTimestamp))):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
                XCTAssertEqual(receivedTimestamp, expectedTimestamp, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    private func testSpecificStoreURL() -> URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("\(type(of: self)).store")
    }
    
    private func deleteCache() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
    
    private func setupEmptyStoreState() {
        deleteCache()
    }
    
    private func undoStoreSideEffects() {
        deleteCache()
    }
}
