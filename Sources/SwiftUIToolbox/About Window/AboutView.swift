//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct AboutView<Panel: View>: View {
    
    private let name: String
    private let version: String
    private let build: String
    private let copyright: String?
    private let developerName: String
    private let panel: () -> Panel
    
    @Environment(\.openWindow) private var openWindow
    
    public init(
        name: String,
        version: String,
        build: String,
        copyright: String? = nil,
        developerName: String,
        @ViewBuilder panel: @escaping () -> Panel
    ) {
        self.name = name
        self.version = version
        self.build = build
        self.copyright = copyright
        self.developerName = developerName
        self.panel = panel
    }
    
    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(nsImage: NSApp?.applicationIconImage ?? NSImage())
                    .shadow(color: .black.opacity(0.2), radius: 4, y: 4)
                    .padding()
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(name)
                            .font(.title)
                            .bold()
                        Spacer()
                        Group {
                            Text("Version \(version)") + Text(" (\(build))")
                        }.foregroundColor(.secondary)
                    }
                    Divider()
                        .padding(.top, -8)
                    Text("Developed by")
                        .bold()
                        .padding(.bottom, 2)
                    Text(developerName)
                        .padding(.bottom, 12)
                    Spacer()
                    if let copyright {
                        Text(copyright)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 30))
            }
            HStack {
                Spacer()
                panel()
            }
            .padding()
            .background(Color(.sRGB, white: 0.0, opacity: 0.1))
        }
    }
}

#endif
