# SwiftUIToolbox

The **SwiftUIToolbox** framework consists of a number of  convenience views and utilities for use with SwiftUI. 

- [Button Styles](#button-styles)
    - [`ActionButtonStyle`](#actionbuttonstyle)
    - [`PrimaryButtonStyle`](#primarybuttonstyle)
    - [`SecondaryButtonStyle`](#primarybuttonstyle)
- [Colors](#colors)
    - [`SystemColors`](#systemcolors)
- [Controls](#controls)
    - [`DimView`](#dimview)
    - [`EnumPicker`](#enumpicker)
    - [`HSeparator`](#hseparator)
    - [`PageDots`](#pagedots)
    - [`PrimaryButton`](#primarybutton)
    - [`SecondaryButton`](#primarybutton)
    - [`VSeparator`](#vseparator)
- [Fonts](#fonts)
    - [ `AllFontsView`](#allfontsview)
- [Modifiers](#modifiers)
    - [`debugPrint(...)`](#debugPrint)
    - [`inverseMask(...)`](#inverseMask)
- [Shapes](#shapes)
    - [`Triangle`](#triangle)
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
- [Wrapped UIKit Views](#wrapped-uikit-views)
    - [`Blur`](#blur)

## Button Styles

### `ActionButtonStyle`

The `ActionButtonStyle` is a `ButtonStyle` that looks like the "Open" button in the App Store or TestFlight apps.

#### Example

```
Button(action: { }) {
    Text("Open")
}.buttonStyle(ActionButtonStyle())
```

### `PrimaryButtonStyle`

The primary button style has a back plate with rounded corners.

### `SecondaryButtonStyle`

The secondary button style has a light back plate with rounded corners.

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

### `DimView`

A black view with 30% opacity (by default) that dims views behind it.

#### Example

```swift
ZStack {
    SomeContentView()
    DimView(opacity: 0.3)
}
```

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

### `HSeparator`

A 1 pixel horizontal separator view.

#### Example

```swift
HSeparator(color: .separator)
```

### `PageDots`

Emulates the UIKit page control.

#### Example

```swift
PageDots(currentPage: 0, pageCount: 3)
```

### `PrimaryButton`

The primary button has a back plate with rounded corners.

### `SecondaryButton`

The secondary button has a light back plate with rounded corners.

### `VSeparator`

A 1 pixel vertical separator view.

```swift
VSeparator(color: .separator)
```

## Fonts

### `AllFontsView`

The `AllFontsView` is a list view that is available in `DEBUG` builds that displays all the available system fonts.

#### Example

```swift
AllFontsView()
```

## Modifiers

### `inverseMask(...)`

Same as the `mask` modifier, only inverted.

### `debugPrint(...)`

Prints a value and returns the unmodified view.

## Shapes

### `Triangle`

Triangle shape that points upwards.

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

## Wrapped UIKit Views

### `Blur`

Wrapper view for `UIVisualEffectView` with blur effect

#### Example

```swift
Blur(isPresented: $showBlur, style: .systemThinMaterial, animated: true)
```
