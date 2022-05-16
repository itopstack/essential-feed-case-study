//
//  FeedImageDataLoader.swift
//  EsstentialFeediOS
//
//  Created by Kittisak Phetrungnapha on 16/5/2565 BE.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
