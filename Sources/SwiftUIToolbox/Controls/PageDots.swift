//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(UIKit)

import SwiftUI

/// Emulates the UIKit page control.
///
/// Example:
///
/// ```
/// PageDots(currentPage: 0, pageCount: 3)
/// ```
public struct PageDots: View {
    
    public let currentPage: Int
    public let pageCount: Int
    public let currentPageColor: (_ page: Int) -> NSUIColor
    public let pageColor: NSUIColor
    
    public init(currentPage: Int,
         pageCount: Int,
         currentPageColor: @escaping (_ page: Int) -> UIColor = { _ in .systemBackground },
         pageColor: UIColor = UIColor.systemGray4.withAlphaComponent(0.6)) {
        self.currentPage = currentPage
        self.pageCount = pageCount
        self.currentPageColor = currentPageColor
        self.pageColor = pageColor
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pageCount) { page in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color(page == currentPage ? currentPageColor(page)
                                                               : pageColor))
                    .animation(.easeInOut(duration: 0.2))
            }
        }
    }
}

struct PageDots_Previews: PreviewProvider {
    static var previews: some View {
        PageDots(currentPage: 0, pageCount: 3)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.blue)
    }
}

#endif
