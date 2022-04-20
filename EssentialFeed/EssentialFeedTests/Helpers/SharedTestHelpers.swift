//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Kittisak Phetrungnapha on 20/4/2565 BE.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
