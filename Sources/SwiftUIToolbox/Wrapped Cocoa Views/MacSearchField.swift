//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

#if os(macOS)

import Cocoa
import SwiftUI

struct MacSearchField: NSViewRepresentable {
    
    @Binding var text: String
    
    private var placeholder: String

    init(text: Binding<String>, placeholder: String = "Search") {
        _text = text
        self.placeholder = placeholder
    }

    func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField(string: placeholder)
        searchField.delegate = context.coordinator
        searchField.isBordered = false
        searchField.isBezeled = true
        searchField.bezelStyle = .roundedBezel
        return searchField
    }

    func updateNSView(_ nsView: NSSearchField, context: Context) {
        nsView.stringValue = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator { self.text = $0 }
    }

    final class Coordinator: NSObject, NSSearchFieldDelegate {
        var mutator: (String) -> Void

        init(_ mutator: @escaping (String) -> Void) {
            self.mutator = mutator
        }

        func controlTextDidChange(_ notification: Notification) {
            if let textField = notification.object as? NSTextField {
                mutator(textField.stringValue)
            }
        }
    }
}

#endif
