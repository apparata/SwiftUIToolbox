//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

#if os(macOS)

import Cocoa
import SwiftUI

public struct MacSearchField: NSViewRepresentable {
    
    @Binding var text: String
    
    private var placeholder: String

    public init(text: Binding<String>, placeholder: String = "Search") {
        _text = text
        self.placeholder = placeholder
    }

    public func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField(string: placeholder)
        searchField.delegate = context.coordinator
        searchField.isBordered = false
        searchField.isBezeled = true
        searchField.bezelStyle = .roundedBezel
        return searchField
    }

    public func updateNSView(_ nsView: NSSearchField, context: Context) {
        nsView.stringValue = text
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator { self.text = $0 }
    }

    final public class Coordinator: NSObject, NSSearchFieldDelegate {
        var mutator: (String) -> Void

        init(_ mutator: @escaping (String) -> Void) {
            self.mutator = mutator
        }

        public func controlTextDidChange(_ notification: Notification) {
            if let textField = notification.object as? NSTextField {
                mutator(textField.stringValue)
            }
        }
    }
}

#endif
