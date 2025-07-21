# SwiftUIToolbox

The **SwiftUIToolbox** framework consists of a number of  convenience views and utilities for use with SwiftUI. 

## License

See the LICENSE file for licensing information.

## Table of Contents

- [Animation](#animation)
- [Async Image](#async-image)
- [Button Styles](#button-styles)
- [Colors](#colors)
- [Controls](#controls)
- [Bottom Sheet](#bottom-sheet)
- [Modifiers](#modifiers)
- [Utility Views](#utility-views)
- [Shapes](#shapes)
- [About Window](#about-window)
- [What's New View](#whats-new-view)
- [Platform Support](#platform-support)

## Animation

### Smooth Spring Animation

A predefined spring animation with optimized parameters for smooth UI transitions.

```swift
import SwiftUIToolbox

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: isExpanded ? 200 : 100, height: 100)
            .onTapGesture {
                withAnimation(.smoothSpring) {
                    isExpanded.toggle()
                }
            }
    }
}
```

### Animation Completion Handler

Track when animations complete using the `onAnimationCompletion` modifier.

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State private var animationCompleted = false
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 100, height: 100)
            .scaleEffect(scale)
            .onAnimationCompletion(for: scale) {
                animationCompleted = true
                print("Scale animation completed")
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    scale = scale == 1.0 ? 1.5 : 1.0
                }
            }
    }
}
```

## Async Image

Custom async image loading with placeholder and error states.

```swift
import SwiftUIToolbox

struct ImageView: View {
    let imageURL = URL(string: "https://example.com/image.jpg")!
    
    var body: some View {
        AsyncImage(url: imageURL) {
            // Placeholder while loading
            ProgressView()
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.3))
        } failed: {
            // Error state
            Image(systemName: "photo")
                .foregroundColor(.gray)
                .frame(width: 200, height: 200)
                .background(Color.red.opacity(0.1))
        }
        .aspectRatio(contentMode: .fit)
        .cornerRadius(12)
    }
}

// Using custom URLSession
struct ImageViewWithCustomSession: View {
    let imageURL = URL(string: "https://example.com/image.jpg")!
    let customSession = URLSession(configuration: .default)
    
    var body: some View {
        AsyncImage(url: imageURL) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 150)
        } failed: {
            Text("Failed to load")
                .foregroundColor(.red)
        }
        .asyncImageURLSession(customSession)
    }
}
```

## Button Styles

### Action Button Style

App Store/TestFlight style button with rounded corners.

```swift
import SwiftUIToolbox

struct ActionButtonExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Download") {
                print("Download tapped")
            }
            .buttonStyle(.action)
            
            Button("Open") {
                print("Open tapped")
            }
            .buttonStyle(ActionButtonStyle())
        }
    }
}
```

### Primary Button Style

Customizable button with background plate and rounded corners.

```swift
struct PrimaryButtonExample: View {
    var body: some View {
        VStack(spacing: 20) {
            // Default primary button
            Button("Continue") {
                print("Continue tapped")
            }
            .buttonStyle(.primary())
            
            // Custom primary button
            Button("Save") {
                print("Save tapped")
            }
            .buttonStyle(.primary(
                cornerRadius: 12,
                textColor: .white,
                plateColor: .green
            ))
            
            // Full customization
            Button("Delete") {
                print("Delete tapped")
            }
            .buttonStyle(PrimaryButtonStyle(
                cornerRadius: 8,
                textColor: .white,
                plateColor: .red
            ))
        }
    }
}
```

### Secondary Button Style

Button with border and transparent background.

```swift
struct SecondaryButtonExample: View {
    var body: some View {
        Button("Cancel") {
            print("Cancel tapped")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}
```

### Scaled on Tap Button Style

Button that scales when pressed.

```swift
struct ScaledButtonExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Tap Me") {
                print("Button tapped")
            }
            .buttonStyle(.scaledOnTap(scale: 0.95))
            
            Button("Press Me") {
                print("Button pressed")
            }
            .buttonStyle(ScaledOnTapButtonStyle(scale: 0.9))
        }
    }
}
```

## Colors

### Codable Colors

Store and retrieve colors from UserDefaults or JSON.

```swift
import SwiftUIToolbox

struct ColorStorageExample: View {
    @AppStorage("userColor") private var storedColor: Color = .blue
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(storedColor)
                .frame(width: 100, height: 100)
            
            Button("Change Color") {
                storedColor = [Color.red, .green, .blue, .purple].randomElement()!
            }
        }
    }
}

// JSON encoding/decoding
struct ColorCodingExample {
    func saveColor(_ color: Color) {
        do {
            let data = try JSONEncoder().encode(color)
            UserDefaults.standard.set(data, forKey: "savedColor")
        } catch {
            print("Failed to encode color: \(error)")
        }
    }
    
    func loadColor() -> Color? {
        guard let data = UserDefaults.standard.data(forKey: "savedColor") else { return nil }
        return try? JSONDecoder().decode(Color.self, from: data)
    }
}
```

### System Colors

Cross-platform color utilities.

```swift
struct SystemColorsExample: View {
    var body: some View {
        VStack {
            Text("System colors work across platforms")
                .foregroundColor(.systemBlue)
            
            Rectangle()
                .fill(.systemGray)
                .frame(width: 100, height: 50)
        }
    }
}
```

## Controls

### Dim View

Semi-transparent overlay for dimming content.

```swift
import SwiftUIToolbox

struct DimViewExample: View {
    @State private var showOverlay = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Main Content")
                Button("Show Overlay") {
                    showOverlay = true
                }
            }
            
            if showOverlay {
                DimView(opacity: 0.4)
                    .onTapGesture {
                        showOverlay = false
                    }
                
                VStack {
                    Text("Overlay Content")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
        }
    }
}
```

### Enum Picker

Type-safe picker for enum values.

```swift
import SwiftUIToolbox

enum Priority: Pickable {
    case low, medium, high, urgent
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .low: return "🟢 Low"
        case .medium: return "🟡 Medium"
        case .high: return "🟠 High"
        case .urgent: return "🔴 Urgent"
        }
    }
}

struct EnumPickerExample: View {
    @State private var selectedPriority: Priority = .medium
    
    var body: some View {
        VStack {
            EnumPicker("Priority", selection: $selectedPriority)
                .pickerStyle(.segmented)
            
            Text("Selected: \(selectedPriority.description)")
                .padding()
        }
    }
}

// Custom label
struct CustomLabelEnumPicker: View {
    @State private var selectedPriority: Priority = .low
    
    var body: some View {
        EnumPicker(selection: $selectedPriority) {
            Label("Task Priority", systemImage: "flag.fill")
        }
        .pickerStyle(.menu)
    }
}
```

### Loading Indicator

Animated loading dots.

```swift
import SwiftUIToolbox

struct LoadingExample: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                LoadingIndicator()
                    .foregroundColor(.blue)
            }
            
            Button(isLoading ? "Loading..." : "Start Loading") {
                isLoading.toggle()
            }
            .disabled(isLoading)
        }
    }
}
```

### Page Dots

Page indicator for pagination.

```swift
import SwiftUIToolbox

struct PageDotsExample: View {
    @State private var currentPage = 0
    let totalPages = 5
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<totalPages, id: \.self) { page in
                    Text("Page \(page + 1)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .tag(page)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            PageDots(currentPage: currentPage, pageCount: totalPages)
                .padding()
        }
    }
}
```

### Primary and Secondary Buttons

Pre-styled button components.

```swift
struct ButtonComponentsExample: View {
    var body: some View {
        VStack(spacing: 20) {
            PrimaryButton("Save Changes") {
                print("Primary action")
            }
            
            SecondaryButton("Cancel") {
                print("Secondary action")
            }
        }
        .padding()
    }
}
```

### HSeparator and VSeparator

Horizontal and vertical separators.

```swift
struct SeparatorExample: View {
    var body: some View {
        VStack {
            Text("Above")
            HSeparator()
            
            HStack {
                Text("Left")
                VSeparator()
                Text("Right")
            }
            
            HSeparator()
            Text("Below")
        }
        .padding()
    }
}
```

## Bottom Sheet

iOS-style bottom sheet with customizable detents.

```swift
#if os(iOS)
import SwiftUIToolbox

struct BottomSheetExample: View {
    @State private var detent: BottomSheetDetent = .hidden
    
    var body: some View {
        ZStack {
            VStack {
                Button("Show Bottom Sheet") {
                    withAnimation {
                        detent = .medium
                    }
                }
            }
            
            BottomSheet(detent: $detent) {
                // Header
                HStack {
                    Text("Settings")
                        .font(.headline)
                    Spacer()
                    Button("Done") {
                        withAnimation {
                            detent = .hidden
                        }
                    }
                }
                .padding()
            } content: {
                // Content
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sheet content goes here")
                    
                    Button("Expand to Large") {
                        withAnimation {
                            detent = .large
                        }
                    }
                    
                    Button("Collapse to Small") {
                        withAnimation {
                            detent = .small
                        }
                    }
                }
                .padding()
            }
            .bottomSheetStyle(
                BottomSheetStyle(
                    detents: [.large, .medium, .small],
                    dragIndicator: true,
                    backgroundColor: .systemBackground,
                    contentScrolls: true
                )
            )
        }
    }
}

// Custom detents
struct CustomDetentExample: View {
    @State private var detent: BottomSheetDetent = .hidden
    
    let customDetents = [
        BottomSheetDetent(.constant(150), allowScrolling: false),
        BottomSheetDetent(.percent(60), allowScrolling: true),
        BottomSheetDetent(.topGap(50), allowScrolling: true, dimBackground: true)
    ]
    
    var body: some View {
        ZStack {
            Button("Show Custom Sheet") {
                withAnimation {
                    detent = customDetents[0]
                }
            }
            
            BottomSheet(detent: $detent) {
                VStack {
                    Text("Custom Bottom Sheet")
                    // Add your content here
                }
                .padding()
            }
            .bottomSheetStyle(
                BottomSheetStyle(detents: customDetents)
            )
        }
    }
}
#endif
```

## Modifiers

### Corner Radius

Apply corner radius to specific corners (iOS/UIKit only).

```swift
#if os(iOS)
import SwiftUIToolbox

struct CornerRadiusExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 150, height: 100)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            
            Rectangle()
                .fill(Color.green)
                .frame(width: 150, height: 100)
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)
                .cornerRadius(25, corners: [.topRight, .bottomLeft])
        }
    }
}
#endif
```

### Smooth Corner Radius

Smooth, continuous corner radius.

```swift
struct SmoothCornerExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 150, height: 100)
                .smoothCornerRadius(20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green)
                .frame(width: 150, height: 100)
                .smoothCornerRadius(15)
        }
    }
}
```

### On First Appear

Execute code only on the first appearance, not on navigation returns.

```swift
import SwiftUIToolbox

struct FirstAppearExample: View {
    @State private var hasAppeared = false
    
    var body: some View {
        VStack {
            Text(hasAppeared ? "Appeared!" : "Waiting...")
            
            NavigationLink("Go to Next View") {
                Text("Navigate back to test onFirstAppear")
            }
        }
        .onFirstAppear {
            hasAppeared = true
            print("This only runs on first appearance")
        }
        .onAppear {
            print("This runs every time")
        }
    }
}
```

### Debug Print

Print debug information about view updates.

```swift
import SwiftUIToolbox

struct DebugExample: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
                .debugPrint("Counter updated to: \(counter)")
            
            Button("Increment") {
                counter += 1
            }
        }
        .debugAction {
            print("View body was called")
        }
    }
}
```

### Inverse Mask

Apply an inverse mask to a view.

```swift
import SwiftUIToolbox

struct InverseMaskExample: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 200)
            .inverseMask {
                Circle()
                    .frame(width: 100, height: 100)
            }
    }
}
```

## Utility Views

### Flip View

3D flip animation between two views.

```swift
import SwiftUIToolbox

struct FlipViewExample: View {
    @State private var isFlipped = false
    
    var body: some View {
        VStack {
            FlipView(isFlipped: isFlipped) {
                // Front view
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 150)
                    .overlay {
                        Text("Front")
                            .foregroundColor(.white)
                            .font(.title)
                    }
            } back: {
                // Back view
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 150)
                    .overlay {
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.title)
                    }
            }
            
            Button("Flip") {
                withAnimation(.smoothSpring) {
                    isFlipped.toggle()
                }
            }
        }
    }
}
```

### Lazy Destination

Lazy evaluation for navigation destinations.

```swift
import SwiftUIToolbox

struct LazyDestinationExample: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go to Heavy View") {
                    LazyDestination {
                        ExpensiveView() // Only created when navigated to
                    }
                }
                
                NavigationLink("Go to Another View") {
                    LazyDestination(AnotherExpensiveView())
                }
            }
        }
    }
}

struct ExpensiveView: View {
    init() {
        print("ExpensiveView created") // Only prints when navigated to
    }
    
    var body: some View {
        Text("This view was lazily loaded")
    }
}
```

### Placeholder

Show placeholder content while data is loading.

```swift
import SwiftUIToolbox

struct PlaceholderExample: View {
    @State private var isLoading = true
    @State private var data: [String] = []
    
    var body: some View {
        List {
            ForEach(data, id: \.self) { item in
                Text(item)
            }
        }
        .placeholder(when: isLoading) {
            VStack {
                ProgressView()
                Text("Loading...")
            }
        }
        .onAppear {
            // Simulate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                data = ["Item 1", "Item 2", "Item 3"]
                isLoading = false
            }
        }
    }
}
```

### Stagger

Staggered animations for multiple views (iOS 18+).

```swift
@available(iOS 18.0, *)
struct StaggerExample: View {
    @State private var showItems = false
    
    var body: some View {
        VStack {
            Button("Toggle Items") {
                showItems.toggle()
            }
            
            Stagger(
                StaggerBehavior(
                    delay: 0.1,
                    maxDelay: 1.0,
                    blurRadius: 5,
                    offset: CGSize(width: 0, height: 50),
                    scale: 0.8,
                    animation: .interpolatingSpring
                )
            ) {
                if showItems {
                    ForEach(1...6, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.7))
                            .frame(height: 60)
                            .overlay {
                                Text("Item \(index)")
                                    .foregroundColor(.white)
                            }
                    }
                }
            }
        }
        .padding()
    }
}
```

### Toolbar Popover

Present a popover from toolbar items.

```swift
import SwiftUIToolbox

struct ToolbarPopoverExample: View {
    @State private var showPopover = false
    
    var body: some View {
        NavigationView {
            Text("Main Content")
                .navigationTitle("Example")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ToolbarPopover(isPresented: $showPopover) {
                            VStack {
                                Text("Popover Content")
                                Button("Close") {
                                    showPopover = false
                                }
                            }
                            .padding()
                        } label: {
                            Button("Show Popover") {
                                showPopover = true
                            }
                        }
                    }
                }
        }
    }
}
```

### With Environment

Inject environment values into views.

```swift
import SwiftUIToolbox

struct WithEnvironmentExample: View {
    var body: some View {
        WithEnvironment(\.colorScheme, .dark) {
            VStack {
                Text("This content is in dark mode")
                    .foregroundColor(.primary)
                
                WithEnvironment(\.font, .largeTitle) {
                    Text("Large title font")
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}
```

### View Controller Presenter

Present UIKit view controllers from SwiftUI.

```swift
#if os(iOS)
import SwiftUIToolbox
import UIKit

struct ViewControllerPresenterExample: View {
    @State private var showViewController = false
    
    var body: some View {
        Button("Present UIKit Controller") {
            showViewController = true
        }
        .sheet(isPresented: $showViewController) {
            ViewControllerPresenter {
                let controller = UINavigationController(
                    rootViewController: MyCustomViewController()
                )
                return controller
            }
        }
    }
}

class MyCustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "UIKit View"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissTapped)
        )
    }
    
    @objc func dismissTapped() {
        dismiss(animated: true)
    }
}
#endif
```

## Shapes

### Triangle

Simple triangle shape pointing upwards.

```swift
import SwiftUIToolbox

struct TriangleExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Triangle()
                .fill(Color.blue)
                .frame(width: 100, height: 80)
            
            Triangle()
                .stroke(Color.red, lineWidth: 3)
                .frame(width: 60, height: 50)
            
            Triangle()
                .fill(LinearGradient(
                    colors: [.purple, .pink],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: 120, height: 100)
        }
    }
}
```

## About Window

### About View

Pre-built about view with app information.

```swift
import SwiftUIToolbox

struct AboutExample: View {
    var body: some View {
        AboutView()
            .frame(width: 300, height: 400)
    }
}

// Custom about view
struct CustomAboutExample: View {
    var body: some View {
        AboutView(
            appIcon: Image("CustomAppIcon"),
            appName: "My Awesome App",
            appVersion: "2.0.1",
            buildNumber: "42",
            copyright: "© 2024 My Company"
        )
    }
}
```

### About Window (macOS)

```swift
#if os(macOS)
import SwiftUIToolbox

struct MacOSAboutExample: View {
    var body: some View {
        Button("Show About Window") {
            AboutWindow.show()
        }
    }
}

// Add to your App's menu
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            AboutCommand()
        }
    }
}
#endif
```

## What's New View

Present what's new information to users.

```swift
import SwiftUIToolbox

struct WhatsNewExample: View {
    @State private var showWhatsNew = false
    
    let whatsNewItems = [
        WhatsNew(
            icon: Image(systemName: "star.fill"),
            title: "New Feature",
            description: "Amazing new functionality added to the app."
        ),
        WhatsNew(
            icon: Image(systemName: "speedometer"),
            title: "Performance Improvements",
            description: "The app is now faster and more responsive."
        ),
        WhatsNew(
            icon: Image(systemName: "paintbrush.fill"),
            title: "UI Updates",
            description: "Fresh new look with improved design."
        )
    ]
    
    var body: some View {
        Button("Show What's New") {
            showWhatsNew = true
        }
        .sheet(isPresented: $showWhatsNew) {
            WhatsNewView(
                title: "What's New in v2.0",
                items: whatsNewItems
            ) {
                showWhatsNew = false
            }
        }
    }
}
```

## Platform Support

### Multiplatform Views

```swift
import SwiftUIToolbox

struct MultiplatformExample: View {
    var body: some View {
        VStack {
            // Works on both iOS and macOS
            #if os(iOS)
            Text("iOS specific content")
                .foregroundColor(.systemBlue)
            #elseif os(macOS)
            Text("macOS specific content")
                .foregroundColor(.systemBlue)
            #endif
            
            // Cross-platform image handling
            if let image = NSUIImage(named: "example") {
                Image(nsUIImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
    }
}
```

### Mouse Tracking (macOS)

```swift
#if os(macOS)
import SwiftUIToolbox

struct MouseTrackingExample: View {
    @State private var mouseLocation: CGPoint = .zero
    @State private var isMouseInside = false
    
    var body: some View {
        Rectangle()
            .fill(isMouseInside ? Color.blue : Color.gray)
            .frame(width: 200, height: 200)
            .overlay {
                Text("Mouse: \(Int(mouseLocation.x)), \(Int(mouseLocation.y))")
                    .foregroundColor(.white)
            }
            .mouseTracker { location, isInside in
                mouseLocation = location
                isMouseInside = isInside
            }
    }
}
#endif
```

### Search Fields

```swift
#if os(macOS)
import SwiftUIToolbox

struct SearchFieldExample: View {
    @State private var searchText = ""
    @State private var sidebarSearchText = ""
    
    var body: some View {
        VStack {
            MacSearchField("Search", text: $searchText)
                .frame(width: 250)
            
            SidebarSearchField("Filter", text: $sidebarSearchText)
                .frame(width: 200)
        }
    }
}
#endif
```

### Window Drag Handle (macOS)

```swift
#if os(macOS)
import SwiftUIToolbox

struct WindowDragExample: View {
    var body: some View {
        VStack {
            WindowDragHandle()
                .frame(height: 30)
            
            Text("Drag the area above to move the window")
                .padding()
        }
    }
}
#endif
```

### Blur Effect (iOS)

```swift
#if os(iOS)
import SwiftUIToolbox

struct BlurExample: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack {
                Text("Content over blur")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .background {
                Blur(style: .systemUltraThinMaterial)
                    .cornerRadius(12)
            }
        }
    }
}
#endif
```

## Utilities

### Search Filter

Generic search and filtering utilities.

```swift
import SwiftUIToolbox

struct Item {
    let name: String
    let category: String
}

struct SearchFilterExample: View {
    @State private var searchText = ""
    
    let items = [
        Item(name: "Apple", category: "Fruit"),
        Item(name: "Banana", category: "Fruit"),
        Item(name: "Carrot", category: "Vegetable")
    ]
    
    var filteredItems: [Item] {
        SearchFilter.filter(items, by: searchText) { item in
            [item.name, item.category]
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(.roundedBorder)
            
            List(filteredItems, id: \.name) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.category)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
    }
}
```

### AppStorage with Defaults

Enhanced AppStorage with default values.

```swift
import SwiftUIToolbox

struct AppStorageExample: View {
    @AppStorage("username", defaults: .standard) 
    private var username: String = "DefaultUser"
    
    @AppStorage("isFirstLaunch", defaults: .standard) 
    private var isFirstLaunch: Bool = true
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            
            Toggle("First Launch", isOn: $isFirstLaunch)
            
            if isFirstLaunch {
                Text("Welcome! This is your first time using the app.")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
```

### Font Utilities

```swift
import SwiftUIToolbox

struct FontExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Numeric Weight: 300")
                .fontWeight(300)
            
            Text("Numeric Weight: 600")
                .fontWeight(600)
            
            Text("Numeric Weight: 900")
                .fontWeight(900)
            
            // View all available fonts
            NavigationLink("View All Fonts") {
                AllFontsView()
            }
        }
    }
}
```

### Error Handling

```swift
import SwiftUIToolbox

struct ErrorHandlingExample: View {
    @StateObject private var errorHandler = ErrorHandler()
    
    var body: some View {
        VStack {
            Button("Trigger Error") {
                errorHandler.handle(ExampleError.someError)
            }
            
            if let error = errorHandler.currentError {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
                
                Button("Dismiss") {
                    errorHandler.clearError()
                }
            }
        }
        .environmentObject(errorHandler)
    }
}

enum ExampleError: LocalizedError {
    case someError
    
    var errorDescription: String? {
        switch self {
        case .someError:
            return "Something went wrong"
        }
    }
}
```
