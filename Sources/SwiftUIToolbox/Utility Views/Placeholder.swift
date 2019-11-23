//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct Placeholder: View {
    
    public let cornerRadius: CGFloat
    public let foreground: Color
    public let background: Color
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .foregroundColor(self.background)
                Text("\(Self.numberFormatter.string(from: geometry.size.width as NSNumber) ?? "?") x \(Self.numberFormatter.string(from: geometry.size.height as NSNumber) ?? "?")")
                    .foregroundColor(self.foreground)
            }
        }
    }
    
    public init(cornerRadius: CGFloat = 0, foreground: Color? = nil, background: Color? = nil) {
        self.cornerRadius = cornerRadius
        self.foreground = foreground ?? Color(.sRGB, white: 0.0, opacity: 0.2)
        self.background = background ?? Color(.sRGB, white: 0.0, opacity: 0.05)
    }
    
    private static let numberFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.usesSignificantDigits = false
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 42
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
