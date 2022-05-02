//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
