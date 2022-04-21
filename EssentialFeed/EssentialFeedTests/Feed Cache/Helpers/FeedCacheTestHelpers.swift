//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 20/4/2565 BE.
//

import Foundation
import EssentialFeed

func uniqueFeedImage() -> FeedImage {
    FeedImage(id: UUID(), description: nil, location: nil, url: anyURL())
}

func uniqueFeedImages() -> (models: [FeedImage], locals: [LocalFeedImage]) {
    let feed = [uniqueFeedImage(), uniqueFeedImage()]
    let localFeed = feed.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    return (feed, localFeed)
}

extension Date {
    
    func minusFeedCacheMaxAge() -> Date {
        adding(days: -7)
    }
    
    func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
