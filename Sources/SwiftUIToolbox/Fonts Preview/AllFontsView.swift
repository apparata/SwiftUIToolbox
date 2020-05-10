//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
#if canImport(UIKit)
import UIKit
typealias KitFont = UIFont
#else
import Cocoa
typealias KitFont = NSFont
#endif

public struct AllFontsView: View {
    
    public var body: some View {
        List(KitFont.familyNames, id: \.self) { fontFamily in
            VStack(alignment: .leading) {
                Text(fontFamily)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .padding(4)
                    .padding(.bottom)
                ForEach(KitFont.fontNames(forFamilyName: fontFamily), id: \.self) { font in
                    Text(font)
                        .font(.custom(font, size: 18))
                }
            }.padding(.vertical)
        }
    }
}

struct AllFontsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AllFontsView()
    }
}

#endif
