//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

extension View {
    func moveWindowOnDrag() -> some View {
        self.overlay(WindowDragHandle())
    }
}

struct WindowDragHandle: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        return WindowDragHandleView()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
}

class WindowDragHandleView: NSView {
    override public func mouseDown(with event: NSEvent) {
        NSApp?.mainWindow?.performDrag(with: event)
    }
}

#endif

