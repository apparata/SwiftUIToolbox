//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import Foundation
import SwiftUI

public extension Font.Weight {
    
    var numeric: Int {
        switch self {
        case .ultraLight: return 100
        case .thin: return 200
        case .light: return 300
        case .regular: return 400
        case .medium: return 500
        case .semibold: return 600
        case .bold: return 700
        case .heavy: return 800
        case .black: return 900
        default: return 400
        }
    }
    
    /// Initialize the font weight with a numeric value from e.g. Figma.
    init(numeric: Int) {
        switch Int(numeric) {
        case ...199: self = .ultraLight
        case 200..<300: self = .thin
        case 300..<400: self = .light
        case 400..<500: self = .regular
        case 500..<600: self = .medium
        case 600..<700: self = .semibold
        case 700..<800: self = .bold
        case 800..<900: self = .heavy
        case 900...: self = .black
        default: self = .regular
        }
    }
}
