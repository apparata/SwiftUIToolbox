//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - AppService Property Wrapper

/// Property wrapper providing access to an app service.
///
/// Example:
///
/// ```
/// @AppService(\.randomNumbers) var randomNumbers
/// ```
@propertyWrapper public struct AppService<Service>: DynamicProperty {
    
    @Environment(\.appServices) private var appServices
    
    public var wrappedValue: Service {
        appServices[keyPath: keyPath]
    }
    
    private let keyPath: KeyPath<AppServices, Service>
    
    public init(_ keyPath: KeyPath<AppServices, Service>) {
        self.keyPath = keyPath
    }
}

// MARK: - WithAppServices View

public struct WithAppServices<Content: View>: View {
    
    @Environment(\.appServices) private var appServices
    
    private let content: (AppServices) -> Content
    
    public init(@ViewBuilder content: @escaping (AppServices) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content(appServices)
    }
}

// MARK: - AppService Modifier

extension View {
    
    /// Modifier for adding/overriding an app service in the environment.
    ///
    /// Example:
    ///
    /// ```
    /// SomeView()
    ///     .appService(\.randomNumbers, RandomNumberService(range: 0...10))
    /// ```
    @available(*, deprecated, message: "Just use @Environment instead.")
    public func appService<Value>(
        _ keyPath: WritableKeyPath<AppServices, Value>,
        _ value: Value
    ) -> some View {
        modifier(AppServiceModifier(keyPath: keyPath, value: value))
    }
}

public struct AppServiceModifier<Value>: ViewModifier {
    
    let keyPath: WritableKeyPath<AppServices, Value>
    let value: Value
    
    @Environment(\.appServices) private var appServices
    
    public init(keyPath: WritableKeyPath<AppServices, Value>, value: Value) {
        self.keyPath = keyPath
        self.value = value
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(\.appServices, updatingAppServices())
    }
    
    private func updatingAppServices() -> AppServices {
        var appServices = appServices
        appServices[keyPath: keyPath] = value
        return appServices
    }
}

// MARK: AppServiceKey

/// Key to use for accessing a custom App Service.
///
/// ```
/// struct RandomNumberServiceKey: AppServiceKey {
///     static let defaultValue = RandomNumberService()
/// }
/// ```
public protocol AppServiceKey {
    associatedtype Value
    static var defaultValue: Value { get }
}

// MARK: AppServices

/// Container for app services accessible from views.
///
/// ```
/// extension AppServices {
///     var randomNumbers: RandomNumberService {
///         get { // swiftlint:disable:this implicit_getter
///             return self[RandomNumberServiceKey.self]
///         }
///         set {
///             self[RandomNumberServiceKey.self] = newValue
///         }
///      }
/// }
/// ```
public struct AppServices: @unchecked Sendable {
    
    private var services: [any AppServiceEntry] = []
    
    public subscript<K: AppServiceKey>(key: K.Type) -> K.Value {
        get {
            value(of: key) ?? key.defaultValue
        }
        set(newValue) {
            update(value: newValue, of: key)
        }
    }
    
    private func value<K: AppServiceKey>(of type: K.Type) -> K.Value? {
        guard let index = self.index(of: type) else {
            return nil
        }
        return (services[index] as? AppService<K>)?.value
    }
    
    private mutating func update<K: AppServiceKey>(value: K.Value, of type: K.Type) {
        if let index = index(of: type) {
            // swiftlint:disable:next force_unwrapping
            var item = services[index] as! AppService<K>
            item.value = value
            services[index] = item
        } else {
            let newItem = AppService(type: type, value: value)
            services.append(newItem)
        }
    }
    
    private func index<K: AppServiceKey>(of type: K.Type) -> Int? {
        services.firstIndex(where: { $0 is AppService<K> })
    }
    
    private struct AppService<K: AppServiceKey>: AppServiceEntry {
        let type: K.Type
        var value: K.Value
    }
}

// MARK: Internals

private protocol AppServiceEntry {
    associatedtype K: AppServiceKey
}

internal struct AppServicesKey: EnvironmentKey {
    internal static let defaultValue = AppServices()
}

extension EnvironmentValues {
    
    internal var appServices: AppServices {
        get { // swiftlint:disable:this implicit_getter
            return self[AppServicesKey.self]
        }
        set {
            self[AppServicesKey.self] = newValue
        }
    }
}
