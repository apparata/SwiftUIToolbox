# SwiftUIToolbox

The **SwiftUIToolbox** framework consists of a number of  convenience views and utilities for use with SwiftUI. 

- [Button Styles](#button-styles)
    - [`ActionButtonStyle`](#actionbuttonstyle)
- [Colors](#colors)
    - [`SystemColors`](#systemcolors)
- [Controls](#controls)
    - [`EnumPicker`](#enumpicker)
- [Fonts](#fonts)
    - [ `AllFontsView`](#allfontsview)
- [Modifiers](#modifiers)
    - [`inverseMask(...)`](#inverseMask)
- [UIKit Previews](#uikit-previews)
    - [`UIViewPreview`](#uiviewpreview)
    - [`UIViewControllerPreview`](#uiviewcontrollerpreview)
- [Utilities](#utilities)
    - [`SearchFilter`](#searchfilter)
- [Utility Views](#utility-views)
    - [`Placeholder`](#placeholder)
- [Wrapped AppKit Views](#wrapped-appkit-views)
    - [`MacSearchField`](#macsearchfield)
    - [`SidebarSearchField`](#sidebarsearchfield)


## Button Styles

### `ActionButtonStyle`

The `ActionButtonStyle` is a `ButtonStyle` that looks like the "Open" button in the App Store or TestFlight apps.

#### Example

```
Button(action: { }) {
    Text("Open")
}.buttonStyle(ActionButtonStyle())
```

## Colors

### `SystemColors`

A `Color` extension that adds the iOS system colors from `UIColor`. 

#### Example

```swift
Color.systemRed
Color.systemGreen
Color.secondaryLabel
Color.systemFill
```

## Controls

### `EnumPicker`

A convenience wrapper for `Picker` that makes it easier to use an `enum` for as the options.

The enum must conform to the `Pickable` protocol.

```swift
public typealias Pickable = CaseIterable
                          & Identifiable
                          & Hashable
                          & CustomStringConvertible
```

#### Example

```swift
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

struct ExampleView: View {
    @State var selectedFruit: Fruit = .apple

    var body: some View {
        EnumPicker("Fruit", selection: $selectedFruit)
            .pickerStyle(SegmentedPickerStyle())
            .padding()
    }
}
```

## Fonts

### `AllFontsView`

The `AllFontsView` is a list view that is available in `DEBUG` builds that displays all the available system fonts.

#### Example

```swift
AllFontsView()
```

## Modifiers

### `inverseMask`

Same as the `mask` modifier, only inverted.

## UIKit Previews

### `UIViewPreview`

Allows for objects that inherit from `UIView` to be previewed in the SwiftUI preview window in Xcode.

### `UIViewControllerPreview`

Allows for objects that inherit from  `UIViewController` to be previewed in the SwiftUI preview window in Xcode.

## Utilities

### `SearchFilter`

Object that conforms to `ObservableObject` for making simple search filters.

## Utility Views

### `Placeholder`

The `Placeholder` view is a rounded rectangle with an optional title and the size of the view as a text label.

#### Example

```swift
Placeholder()
    .frame(width: 150, height: 100)
```

## Wrapped AppKit Views

### `MacSearchField`

Wrapper view for `NSSearchField`.

### `SidebarSearchField`

Wrapper view for `NSSearchField` specifically for use in the main siderbar.
