//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
