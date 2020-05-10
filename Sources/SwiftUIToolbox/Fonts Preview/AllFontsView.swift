//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(SwiftUI) && canImport(UIKit) && DEBUG
import SwiftUI
import UIKit

public struct AllFontsView: View {
    
    public var body: some View {
        List(UIFont.familyNames, id: \.self) { fontFamily in
            VStack(alignment: .leading) {
                Text(fontFamily)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .padding(4)
                    .padding(.bottom)
                ForEach(UIFont.fontNames(forFamilyName: fontFamily), id: \.self) { font in
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
