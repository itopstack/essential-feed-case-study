//
//  FeedImageViewModel.swift
//  EsstentialFeediOS
//
//  Created by Kittisak Phetrungnapha on 19/5/2565 BE.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
