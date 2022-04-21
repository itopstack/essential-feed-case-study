//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Kittisak Phetrungnapha on 21/4/2565 BE.
//

import Foundation

internal enum FeedCachePolicy {
    
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static var maxCacheAgeInDays = 7
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
