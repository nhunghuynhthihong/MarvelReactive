//
//  AsyncImageCache.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/15/20.
//

import Foundation
import SwiftUI
class AsyncImageCache {
    
    // 1
    static let shared = AsyncImageCache()
    // 2
    private var cache: NSCache = NSCache<NSString, UIImage>()
    // 3
    subscript(key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set(image) { image == nil ? self.cache.removeObject(forKey: (key as NSString)) : self.cache.setObject(image!, forKey: (key as NSString)) }
    }
}
