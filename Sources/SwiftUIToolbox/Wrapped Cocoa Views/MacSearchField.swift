//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

#if os(macOS)

import Cocoa
import SwiftUI

/// Wrapper view for `NSSearchField`.
public struct MacSearchField: NSViewRepresentable {
    
    @Binding var text: String
    
    private var placeholder: String
    
    private var didBeginEditing: ((String) -> Void)?
    private var didEndEditing: ((String) -> Void)?
    private var action: ((String) -> Void)?

    public init(text: Binding<String>,
                placeholder: String = "Search",
                didBeginEditing: ((String) -> Void)? = nil,
                didEndEditing: ((String) -> Void)? = nil,
                action: ((String) -> Void)? = nil) {
        _text = text
        self.placeholder = placeholder
        self.didBeginEditing = didBeginEditing
        self.didEndEditing = didEndEditing
        self.action = action
    }

    public func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField(string: placeholder)
        searchField.delegate = context.coordinator
        searchField.isBordered = false
        searchField.isBezeled = true
        searchField.bezelStyle = .roundedBezel
        searchField.cell?.sendsActionOnEndEditing = false
        searchField.target = context.coordinator
        searchField.action = #selector(context.coordinator.searchAction(_:))
        return searchField
    }
    
    public func updateNSView(_ nsView: NSSearchField, context: Context) {
        nsView.stringValue = text
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(mutator: { self.text = $0 },
                    didBeginEditing: didBeginEditing,
                    didEndEditing: didEndEditing,
                    action: action)
    }

    final public class Coordinator: NSObject, NSSearchFieldDelegate {
        var mutator: (String) -> Void
        var didBeginEditing: ((String) -> Void)?
        var didEndEditing: ((String) -> Void)?
        var action: ((String) -> Void)?

        init(mutator: @escaping (String) -> Void,
             didBeginEditing: ((String) -> Void)?,
             didEndEditing: ((String) -> Void)?,
             action: ((String) -> Void)?){
            self.mutator = mutator
            self.didBeginEditing = didBeginEditing
            self.didEndEditing = didEndEditing
            self.action = action
        }

        public func controlTextDidChange(_ notification: Notification) {
            if let textField = notification.object as? NSTextField {
                mutator(textField.stringValue)
            }
        }
        
        public func controlTextDidBeginEditing(_ notification: Notification) {
            if let textField = notification.object as? NSTextField {
                didBeginEditing?(textField.stringValue)
            }
        }
        
        public func controlTextDidEndEditing(_ notification: Notification) {
            if let textField = notification.object as? NSTextField {
                didEndEditing?(textField.stringValue)
            }
        }
        
        @objc
        fileprivate func searchAction(_ sender: NSTextField?) {
            action?(sender?.stringValue ?? "")
        }
    }
}

#endif
