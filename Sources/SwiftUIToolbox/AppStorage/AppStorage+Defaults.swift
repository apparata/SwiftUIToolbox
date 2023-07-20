import SwiftUI

/// Defaults for AppStorage settings.
///
/// Example:
///
/// ```swift
/// enum ColorMode: String, CaseIterable {
///     case system = "System"
///     case light = "Light"
///     case dark = "Dark"
/// }
///
/// struct AppSettings: AppStorageDefaults {
///     var colorMode: ColorMode { .dark }
/// }
///
/// struct ColorSchemeCommands: Commands {
///
///     @AppStorage(\AppSettings.colorMode) private var colorMode
///
///     var body: some Commands {
///         CommandGroup(after: .windowArrangement) {
///             Picker("Color Mode", selection: $colorMode) {
///                 ForEach(ColorMode.allCases, id: \.self) { mode in
///                     Text(mode.rawValue)
///                         .tag(mode.rawValue)
///                 }
///             }
///             .pickerStyle(.inline)
///         }
///     }
/// }
/// ```
public protocol AppStorageDefaults: ParameterizableAppStorageDefaults {
    init()
}

extension AppStorageDefaults {
    public static var defaults: Self { Self() }
}

public protocol ParameterizableAppStorageDefaults {
    static var defaults: Self { get }
}

extension AppStorage {
    
    /// Creates a property that can read and write to a string user default.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == String {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }

    /// Creates a property that can read and write to an integer user default,
    /// transforming that to RawRepresentable data type.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value : RawRepresentable, Value.RawValue == Int {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }

    /// Creates a property that can read and write to a user default as data.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == Data {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }
    
    /// Creates a property that can read and write to an integer user default.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == Int {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }
    
    /// Creates a property that can read and write to a string user default,
    /// transforming that to RawRepresentable data type.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value : RawRepresentable, Value.RawValue == String {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }

    /// Creates a property that can read and write to a url user default.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == URL {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }
    
    /// Creates a property that can read and write to a double user default.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == Double {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }

    /// Creates a property that can read and write to a boolean user default.
    public init<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) where Value == Bool {
        let key = Self.keyFromKeyPath(keyPath)
        self.init(wrappedValue: Defaults.defaults[keyPath: keyPath], key)
    }
    
    private static func keyFromKeyPath<Defaults: ParameterizableAppStorageDefaults>(_ keyPath: KeyPath<Defaults, Value>) -> String {
        let key = "setting.\(String("\(keyPath)".dropFirst()))"
        return key
    }
}
