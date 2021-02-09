//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if os(iOS)

import SwiftUI
import UIKit
>
private let memoryCacheCapacity = megabyte(128)
private let diskCacheCapacity = megabyte(128)

private let urlSession: URLSession = {
    let config = URLSessionConfiguration.default
    config.urlCache = urlCache
    return URLSession(configuration: config)
}()

private let urlCache = URLCache(memoryCapacity: memoryCacheCapacity,
                                diskCapacity: diskCacheCapacity,
                                diskPath: "swiftuitoolbox_ImageCache")

public enum AsyncImageError: Error {
    case failedToLoad(underlying: Swift.Error)
    case noImageData
    case invalidImageData
}

public enum AsyncImageState {
    case ready
    case progressing
    case cancelled
    case failed(Error)
    case success(UIImage)
}

// MARK: - AsyncImageLoader

public class AsyncImageLoader: ObservableObject {
        
    @Published public var state: AsyncImageState = .ready
    
    private var imageURLRequest: URLRequest?
    private weak var loadTask: URLSessionDataTask?
    private let loadLock = NSLock()
    
    public static func flushCache() {
        urlCache.removeAllCachedResponses()
    }
    
    public init() {
        //
    }
    
    // MARK: Load Image
    
    public func loadImage(url: URL) {
        
        state = .progressing
        
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 60.0)
        
        logCacheStatus(for: request)
        
        // First attempt to retrieve image from cache.
        if let cachedResponse = urlCache.cachedResponse(for: request) {
            
            loadLock.lock( /* --------------- 🔒 LOAD LOCK --------------- */ )
            imageURLRequest = request
            loadLock.unlock( /* -------------------------------------------*/ )
            
            if Thread.isMainThread {
                handleResult(.success(cachedResponse.data), url: url)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.handleResult(.success(cachedResponse.data), url: url)
                }
            }
            return
        }
        
        // Then attampt to download image instead.
        let task = urlSession.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                switch (data, error) {
                case (_, .some(let error)):
                    self?.handleResult(.failure(error), url: url)
                case (.some(let data), _):
                    self?.handleResult(.success(data), url: url)
                default:
                    self?.handleResult(.failure(AsyncImageError.noImageData), url: url)
                }
            }
        }
        
        loadLock.lock( /* ------------------ 🔒 LOAD LOCK ---------------- */ )
        imageURLRequest = request
        loadTask?.cancel()
        loadTask = task
        task.resume()
        loadLock.unlock( /* ---------------------------------------------- */ )
    }
    
    // MARK: - Handle Result
    
    private func handleResult(_ result: Result<Data, Error>, url: URL) {
        switch result {
        case .success(let imageData):
            guard let image = UIImage(data: imageData) else {
                state = .failed(AsyncImageError.invalidImageData)
                return
            }
         
            loadLock.lock( /* ---------------- 🔒 LOAD LOCK -------------- */ )
            let isLatestRequestedImage = (url == imageURLRequest?.url)
            loadLock.unlock( /* ------------------------------------------ */ )
            
            if isLatestRequestedImage {
                state = .success(image)
            }

        case .failure(let error):
            if isCancellationError(error) {
                state = .cancelled
            } else {
                state = .failed(error)
            }
        }
    }
}

// MARK: - Helpers

private func megabyte(_ multiplier: Int) -> Int {
    return multiplier * 1024 * 1024
}

private func isCancellationError(_ error: Error) -> Bool {
    if (error as NSError).code == NSURLErrorCancelled {
        return true
    }
    return false
}

// MARK: - Debug

extension AsyncImageLoader {
    
    #if DEBUG
    static var isDebugModeEnabled = false
    #endif
    
    private func logCacheStatus(for request: URLRequest) {
        #if DEBUG
        guard AsyncImageLoader.isDebugModeEnabled else {
            return
        }
        
        // swiftlint:disable force_unwrapping
        if urlCache.cachedResponse(for: request) == nil {
            print("❌ \(request.url!)")
        } else {
            print("✅ \(request.url!)")
        }
        // swiftlint:enable force_unwrapping
        #endif
    }
}

#endif
