//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import Foundation
import Combine

public protocol SearchFilterable {
    func isMatch(for searchString: String) -> Bool
}

public class SearchFilter<T: SearchFilterable>: ObservableObject {
    
    @Published public var searchText: String = ""
    
    public init() {
        //
    }
    
    public func apply(to values: [T]) -> [T] {
        let matchString = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        return values.filter {
            if matchString.isEmpty {
                return true
            } else {
                return $0.isMatch(for: matchString)
            }
        }
    }
}
