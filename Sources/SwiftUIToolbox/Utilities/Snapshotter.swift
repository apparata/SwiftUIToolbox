//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI
#if os(macOS)
import AppKit
#else
import UIKit
#endif

public final class Snapshotter {
    
    #if os(macOS)
    
    public enum Format {
        case tiff
        case bmp
        case gif
        case jpeg
        case png
        case jpeg2000
        
        fileprivate var fileType: NSBitmapImageRep.FileType {
            switch self {
            case .tiff: return .tiff
            case .bmp: return .bmp
            case .gif: return .gif
            case .jpeg: return .jpeg
            case .png: return .png
            case .jpeg2000: return .jpeg2000
            }
        }
    }
    
    #else
    
    public enum Format {
        case png
        case jpeg(quality: CGFloat)
    }
    
    #endif
    
    public init() {
        //
    }
        
    #if os(macOS)
    public func rasterizeView<Content: View>(_ view: Content,
                                             as format: Format,
                                             size: CGSize,
                                             displayScale: CGFloat = 1) -> Data? {
        let nsView = NSHostingView(rootView: view)
        nsView.frame = CGRect(origin: .zero, size: size)
        return rasterizeNSView(nsView, as: format)
    }
    
    private func rasterizeNSView(_ view: NSView, as format: Format) -> Data? {
        guard let bitmapRepresentation = view
                .bitmapImageRepForCachingDisplay(in: view.bounds) else {
            return nil
        }
        
        bitmapRepresentation.size = view.bounds.size
        view.cacheDisplay(in: view.bounds, to: bitmapRepresentation)
        return bitmapRepresentation.representation(using: format.fileType,
                                                   properties: [:])
    }
    
    #else

    public func rasterizeView<Content: View>(_ view: Content,
                                             as format: Format,
                                             width: CGFloat,
                                             height: CGFloat,
                                             displayScale: CGFloat = 1,
                                             backgroundColor: UIColor?) -> Data? {
        rasterizeView(view, as: format, frame: CGRect(x: 0, y: 0, width: width, height: height), displayScale: displayScale, backgroundColor: backgroundColor)
    }
    
    public func rasterizeView<Content: View>(_ view: Content,
                                             as format: Format,
                                             frame: CGRect,
                                             displayScale: CGFloat = 1,
                                             backgroundColor: UIColor?) -> Data? {
        guard let image = rasterizeView(view, frame: frame, displayScale: displayScale, backgroundColor: backgroundColor) else {
            return nil
        }
        switch format {
        case .png:
            return image.pngData()
        case .jpeg(quality: let quality):
            return image.jpegData(compressionQuality: quality)
        }
    }
    
    public func rasterizeView<Content: View>(_ view: Content, frame: CGRect, displayScale: CGFloat = 1, backgroundColor: UIColor?) -> UIImage? {
        let controller = UIHostingController(rootView: view)
        
        controller.additionalSafeAreaInsets = UIEdgeInsets(
            top: -controller.view.safeAreaInsets.top,
            left: -controller.view.safeAreaInsets.left,
            bottom: -controller.view.safeAreaInsets.bottom,
            right: -controller.view.safeAreaInsets.right)
        
        let bounds = CGRect(origin: .zero, size: frame.size)
        
        controller.view.frame = CGRect(origin: .zero, size: frame.size)
                
        let format = UIGraphicsImageRendererFormat()
        format.scale = displayScale
        let image = UIGraphicsImageRenderer(size: controller.view.layer.frame.size, format: format).image { context in
            if let backgroundColor {
                backgroundColor.setFill()
                context.fill(bounds)
            }
            controller.view.drawHierarchy(in: frame, afterScreenUpdates: true)
        }

        return image
    }
    
    #endif
}
