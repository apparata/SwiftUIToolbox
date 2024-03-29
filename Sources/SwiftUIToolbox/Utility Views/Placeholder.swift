//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

/// The `Placeholder` view is a rounded rectangle with an optional title and the size of the view as a
/// text label.
public struct Placeholder: View {
    
    public let title: String?
    public let cornerRadius: CGFloat
    public let foreground: Color
    public let background: Color
        
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(background)
                VStack {
                    title.map {
                        Text($0)
                            .foregroundColor(foreground)
                    }
                    Text(makeText(geometry: geometry))
                        .foregroundColor(foreground)
                }
            }
        }
    }
    
    public init(title: String? = nil, cornerRadius: CGFloat = 0, foreground: Color? = nil, background: Color? = nil) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.foreground = foreground ?? Color(.sRGB, white: 0.0, opacity: 0.2)
        self.background = background ?? Color(.sRGB, white: 0.0, opacity: 0.05)
    }
    
    private func makeText(geometry: GeometryProxy) -> String {
        return "\(Self.numberFormatter.string(from: geometry.size.width as NSNumber) ?? "?") x \(Self.numberFormatter.string(from: geometry.size.height as NSNumber) ?? "?")"
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

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
            .frame(width: 150, height: 100)
            .previewLayout(.sizeThatFits)
    }
}
