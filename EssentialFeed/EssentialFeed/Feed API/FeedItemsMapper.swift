//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 9/4/2565 BE.
//

import Foundation

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [Item]
        
        var feeds: [FeedItem] {
            items.map { $0.item }
        }
    }
    
    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static var OK_200: Int {
        200
    }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoaderResult {
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(root.feeds)
    }
}
