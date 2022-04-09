//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 9/4/2565 BE.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
