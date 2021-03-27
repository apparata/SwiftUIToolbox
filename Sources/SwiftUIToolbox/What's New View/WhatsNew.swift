//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import Foundation

public struct WhatsNew {
    
    public struct Hint: Identifiable {
        public var id: String { title }
        public let title: String
        public let subtitle: String
        public let icon: String
    }
    
    public let welcome: String
    public let appName: String
    public let hints: [Hint]
    public let continueButton: String
    
    public init(welcome: String = "Welcome to",
         appName: String,
         hints: [Hint],
         continueButton: String = "Continue") {
        self.welcome = welcome
        self.appName = appName
        self.hints = hints
        self.continueButton = continueButton
    }
}
