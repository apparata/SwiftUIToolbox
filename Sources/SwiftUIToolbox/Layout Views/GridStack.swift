//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let rowHeight: CGFloat
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0 ..< columns) { column in
                    VStack(alignment: .leading) {
                        ForEach(0 ..< self.rows) { row in
                            self.content(row, column)
                                .frame(height: self.rowHeight)
                        }
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, rowHeight: CGFloat = 30, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.rowHeight = rowHeight
        self.content = content
    }
}
