//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 17/4/2565 BE.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
