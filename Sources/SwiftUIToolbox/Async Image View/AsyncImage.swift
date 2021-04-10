//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
import SwiftUI
import Combine

#if canImport(AppKit)
public typealias PortableImage = NSImage
#elseif canImport(UIKit)
public typealias PortableImage = UIImage
#endif

extension Image {
    init(_ portableImage: PortableImage) {
        #if canImport(AppKit)
        self.init(nsImage: portableImage)
        #elseif canImport(UIKit)
        self.init(uiImage: portableImage)
        #endif
    }
}


public enum AsyncImageState {
    case ready
    case progressing
    case cancelled
    case failed(Error)
    case success(PortableImage)
}

extension AsyncImageState {
    
    public var isReady: Bool {
        switch self {
        case .ready: return true
        default: return false
        }
    }
}

public enum AsyncImageError: Error {
    case invalidImageData
}

// MARK: - Async Image

/// Asynchronously loaded image.
///
/// Uses `URLSession.shared` by default, which can be overridden using a custom modifier
/// `.asyncImageURLSession(urlSession)` for e.g. using a non-default `URLCache`.
///
/// Example:
///
/// ```
/// AsyncImage(url: url, placeholder: {
///     Color.green
/// }, failed: {
///     Color.red
/// })
/// .aspectRatio(contentMode: .fit)
/// ```
public struct AsyncImage<Placeholder: View, Failed: View>: View {
    
    @StateObject private var imageLoader = AsyncImageLoader()
    
    @Environment(\.asyncImageURLSession) private var urlSession
    
    private let url: URL
    
    private let placeholder: Placeholder
    
    private let failed: Failed
    
    public init(url: URL,
                @ViewBuilder placeholder: () -> Placeholder,
                @ViewBuilder failed: () -> Failed) {
        self.url = url
        self.placeholder = placeholder()
        self.failed = failed()
    }
    
    public var body: some View {
        content
            .onAppear {
                imageLoader.loadImage(url: url, urlSession: urlSession)
            }
    }
    
    @ViewBuilder private var content: some View {
        switch imageLoader.state {
        case .ready: placeholder
        case .progressing: placeholder
        case .cancelled: failed
        case .failed: failed
        case .success(let image):
            Image(image)
                .resizable()
        }
    }
}

// MARK: - Async Image Loader

public class AsyncImageLoader: ObservableObject {

    @Published public var state: AsyncImageState = .ready
    
    private var subscription: AnyCancellable?
    
    private static let queue = DispatchQueue(label: "AsyncImageLoader")
        
    public init() {
        //
    }
    
    func loadImage(url: URL, urlSession: URLSession) {
        
        guard state.isReady else {
            return
        }
        
        state = .progressing
        subscription = urlSession.dataTaskPublisher(for: url)
            .tryMap { try Self.image(from: $0.data) }
            .subscribe(on: Self.queue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let error):
                    self?.state = .failed(error)
                }
            }, receiveValue: { [weak self] image in
                self?.state = .success(image)
            })
    }
    
    func cancel() {
        subscription?.cancel()
        state = .cancelled
    }
    
    private static func image(from data: Data) throws -> PortableImage {
        guard let image = PortableImage(data: data) else {
            throw AsyncImageError.invalidImageData
        }
        return image
    }
    
}

// MARK: - Environment Key/Value

struct AsyncImageURLSessionKey: EnvironmentKey {
    static let defaultValue = URLSession.shared
}

extension EnvironmentValues {
    var asyncImageURLSession: URLSession {
        get {
            return self[AsyncImageURLSessionKey.self]
        }
        set {
            self[AsyncImageURLSessionKey.self] = newValue
        }
    }
}

struct AsyncImageURLSessionModifier: ViewModifier {
    let value: URLSession
    func body(content: Content) -> some View {
        content.environment(\.asyncImageURLSession, value)
    }
}

extension View {
    func asyncImageURLSession(_ value: URLSession) -> some View {
        self.modifier(AsyncImageURLSessionModifier(value: value))
    }
}


