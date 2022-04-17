//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 17/4/2565 BE.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
