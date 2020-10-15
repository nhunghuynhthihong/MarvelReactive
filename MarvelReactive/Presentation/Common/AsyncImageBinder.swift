//
//  AsyncImageBinder.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/15/20.
//

import Foundation
import Combine
import UIKit
// 1
class AsyncImageBinder: ObservableObject {
    private var subscription: AnyCancellable?
    private var cache = AsyncImageCache.shared
    
    @Published private(set) var image: UIImage?
    // 3
    func load(url: URL) {
        if let image: UIImage = cache[url.absoluteString] {
                self.image = image
                return
            }
        subscription = URLSession.shared
                           .dataTaskPublisher(for: url)      // 1
                           .map { UIImage(data: $0.data) }   // 2
                           .replaceError(with: nil)
            .handleEvents(receiveOutput: { self.cache[url.absoluteString] = $0 })   // 3
                           .receive(on: DispatchQueue.main)  // 4
                           .assign(to: \.image, on: self)    // 5
    }
    func cancel() {
        subscription?.cancel()
    }
}
