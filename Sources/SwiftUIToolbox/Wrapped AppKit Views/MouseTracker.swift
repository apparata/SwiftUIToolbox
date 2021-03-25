//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public extension View {
    
    func onMouseMove(_ onMove: @escaping (CGPoint) -> Void) -> some View {
        MouseTracker(onMove: onMove) {
            self
        }
    }
}

public struct MouseTracker<Content>: View where Content: View {
    
    private let onMove: (CGPoint) -> Void
    
    private let content: () -> Content
    
    public init(onMove: @escaping (CGPoint) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.onMove = onMove
        self.content = content
    }
    
    public var body: some View {
        TrackingAreaRepresentable(onMove: onMove, content: content())
    }
}

private struct TrackingAreaRepresentable<Content>: NSViewRepresentable where Content: View {
    
    let onMove: (CGPoint) -> Void
    
    let content: Content
    
    public func makeNSView(context: Context) -> NSHostingView<Content> {
        return TrackingNSHostingView(onMove: onMove, rootView: self.content)
    }
    
    public func updateNSView(_ nsView: NSHostingView<Content>, context: Context) {
        //
    }
}

private class TrackingNSHostingView<Content>: NSHostingView<Content> where Content: View {
    
    let onMove: (CGPoint) -> Void
    
    init(onMove: @escaping (CGPoint) -> Void, rootView: Content) {
        self.onMove = onMove
        super.init(rootView: rootView)
        setupTrackingArea()
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) not supported")
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    func setupTrackingArea() {
        let options: NSTrackingArea.Options = [.mouseMoved, .activeAlways, .inVisibleRect]
        self.addTrackingArea(NSTrackingArea.init(rect: .zero, options: options, owner: self, userInfo: nil))
    }
        
    override func mouseMoved(with event: NSEvent) {
        self.onMove(self.convert(event.locationInWindow, from: nil))
    }
}

#endif

