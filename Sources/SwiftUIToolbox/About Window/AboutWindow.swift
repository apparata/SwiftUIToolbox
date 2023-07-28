//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct AboutWindow: Scene {

	public static let windowID = "about"
	
    private let developedBy: String
    
    private let attributionsWindowID: String?
    
    @Environment(\.openWindow) private var openWindow
    
    public init(developedBy: String, attributionsWindowID: String? = nil) {
        self.developedBy = developedBy
        self.attributionsWindowID = attributionsWindowID
    }
    
	public var body: some Scene {
		Window("About", id: Self.windowID) {
			AboutView(
				name: Bundle.main.name,
				version: Bundle.main.version,
				build: Bundle.main.buildVersion,
				copyright: Bundle.main.copyright,
				developerName: developedBy,
                panel: {
                    if let attributionsWindowID {
                        Button {
                            openWindow(id: attributionsWindowID)
                        } label: {
                            Text("Attributions")
                        }
                    }
                })
			.frame(minWidth: 500, maxWidth: 500, minHeight: 260, maxHeight: 260)
		}
		.commandsRemoved() // Don't show window in Windows menu
		.defaultPosition(.center)
		.defaultSize(width: 500, height: 260)
		.windowResizability(.contentSize)
		.windowStyle(.hiddenTitleBar)
	}
}

#endif
