//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 6/4/2565 BE.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
