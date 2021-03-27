//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public typealias Pickable = CaseIterable
                          & Identifiable
                          & Hashable
                          & CustomStringConvertible

/// A convenience wrapper for `Picker` that makes it easier to use an `enum` for as the options.
///
/// The enum must conform to the `Pickable` protocol.
///
/// Example:
///
/// ```
/// enum Fruit: Pickable {
///     case apple
///     case banana
///     case mango
///     case orange
///     case pear
///
///     var id: Self { self }
///
///     var description: String {
///         switch self {
///         case .apple: return "🍎 Apple"
///         case .banana: return "🍌 Banana"
///         case .mango: return "🥭 Mango"
///         case .orange: return "🍊 Orange"
///         case .pear: return "🍐 Pear"
///         }
///     }
/// }
///
/// struct ExampleView: View {
///     @State var selectedFruit: Fruit = .apple
///
///     var body: some View {
///         EnumPicker("Fruit", selection: $selectedFruit)
///             .pickerStyle(SegmentedPickerStyle())
///             .padding()
///     }
/// }
/// ```
public struct EnumPicker<Enum: Pickable, Label: View>: View {
    
    private let label: Label
    
    @Binding private var selection: Enum

    public var body: some View {
        Picker(selection: $selection, label: label) {
            ForEach(Array(Enum.allCases)) { value in
                Text(value.description).tag(value)
            }
        }
    }
    
    public init(selection: Binding<Enum>, label: Label) {
        self.label = label
        _selection = selection
    }
}

public extension EnumPicker where Label == Text {

    init(_ titleKey: LocalizedStringKey, selection: Binding<Enum>) {
        label = Text(titleKey)
        _selection = selection
    }

    init<S: StringProtocol>(_ title: S, selection: Binding<Enum>) {
        label = Text(title)
        _selection = selection
    }
}

struct EnumPicker_Previews: PreviewProvider {
    
    enum Fruit: Pickable {
        case apple
        case banana
        case mango
        case orange
        case pear
    
        var id: Self { self }
    
        var description: String {
            switch self {
            case .apple: return "🍎 Apple"
            case .banana: return "🍌 Banana"
            case .mango: return "🥭 Mango"
            case .orange: return "🍊 Orange"
            case .pear: return "🍐 Pear"
            }
        }
    }
    
    static var previews: some View {
        EnumPicker("Fruit", selection: .constant(Fruit.apple))
            .pickerStyle(SegmentedPickerStyle())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
