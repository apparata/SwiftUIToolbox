//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import Foundation

protocol SearchFilterable {
    func isMatch(for searchString: String) -> Bool
}

class SearchFilter<T: SearchFilterable>: ObservableObject {
    
    @Published var searchText: String = ""
    
    func apply(to values: [T]) -> [T] {
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
