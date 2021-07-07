//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if os(iOS)

import SwiftUI
import UIKit

// MARK: - Bottom Sheet Height

public enum BottomSheetHeight: Equatable {
    case constant(Int)
    case topGap(Int)
    case percent(Int)
    case hidden
}

// MARK: - Bottom Sheet Detent

/// While `BottomSheetDetent` conforms to `Equatable`, you should not use this for equality
/// in your own code, as it takes some internal state into account, that for external purposes would mean
/// that detents that appear equal are not equal. Instead, compare the `id` property for equality.
public struct BottomSheetDetent: Equatable, Identifiable {
        
    public let id: UUID
    
    public let sheetHeight: BottomSheetHeight

    public let allowScrolling: Bool
    
    public let dimBackground: Bool
    
    fileprivate var transientAnimationOffset: CGFloat = 0
    
    fileprivate var isVisible: Bool {
        print("isVisible: \(!isHidden)")
        return !isHidden
    }
    
    fileprivate var isHidden: Bool {
        switch sheetHeight {
        case .hidden: return true
        default: return false
        }
    }
    
    public init(id: UUID = UUID(),
                _ height: BottomSheetHeight,
                allowScrolling: Bool = false,
                dimBackground: Bool = false) {
        self.id = id
        self.sheetHeight = height
        self.allowScrolling = allowScrolling
        self.dimBackground = dimBackground
    }
           
    public static let large = BottomSheetDetent(.topGap(10),
                                                allowScrolling: true,
                                                dimBackground: true)
    public static let medium = BottomSheetDetent(.percent(50))
    public static let small = BottomSheetDetent(.constant(200))
    public static let minimal = BottomSheetDetent(.constant(80))
    public static let hidden = BottomSheetDetent(.hidden)
}

fileprivate extension BottomSheetDetent {

    var topGap: CGFloat {
        switch sheetHeight {
        case .topGap(let gap): return CGFloat(gap)
        default: return 0
        }
    }

    func height(in containerHeight: CGFloat) -> CGFloat {
        switch sheetHeight {
        case .constant(let height): return CGFloat(height)
        case .topGap(let gap): return containerHeight - CGFloat(gap)
        case .percent(let percent): return (CGFloat(percent) / 100) * containerHeight
        case .hidden: return -100
        }
    }
    
    func topOffset(in containerHeight: CGFloat) -> CGFloat {
        return containerHeight - height(in: containerHeight)
    }
    
    func with(transientAnimationOffset: CGFloat) -> Self {
        var detent = self
        detent.transientAnimationOffset = transientAnimationOffset
        return detent
    }
    
    static func maxHeight(in containerHeight: CGFloat, detents: [Self]) -> CGFloat {
        return detents.map { $0.height(in: containerHeight) }.max() ?? 0
    }
}

// MARK: - Bottom Sheet View

public struct BottomSheet<Header: View, Content: View>: View {

    @Environment(\.bottomSheetStyle) private var style
        
    @Binding private var detent: BottomSheetDetent
    
    @State private var transitionOffset: CGFloat = 0
    
    public var detents: [BottomSheetDetent] {
        style.detents
    }
    
    private let header: Header
    private let content: Content
    
    @GestureState private var translation: CGFloat = 0

    public init(detent: Binding<BottomSheetDetent>, @ViewBuilder header: () -> Header, @ViewBuilder content: () -> Content) {
        self._detent = detent
        self.header = header()
        self.content = content()
    }
    
    public var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let maxHeight = BottomSheetDetent.maxHeight(in: height, detents: detents)
            
            ZStack {
                style.backgroundColor
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .shadow(color: style.dropShadow ? .black.opacity(0.15) : .clear,
                            radius: style.dropShadow ? 8 : 0, x: 0, y: 0)
                    .ignoresSafeArea(.all, edges: .bottom)

                VStack(spacing: 0) {
                    if style.dragIndicator {
                        Capsule()
                            .fill(style.dragIndicatorColor)
                            .frame(width: 36, height: 5)
                            .padding(.top, 5)
                            .padding(.bottom, 7)
                    }
                    header
                    if style.contentScrolls, detent.allowScrolling {
                        ScrollView(.vertical) {
                            VStack(spacing: 0) {
                                content
                                    .frame(maxWidth: .infinity)
                            }
                            .background(GeometryReader { geo in
                                let y = geo.frame(in: .named("BottomSheetCoordinateSpace")).minY
                                if y > 70 {
                                    Spacer()
                                        .onAppear {
                                            transitionToNextDetent(containerHeight: height)
                                        }
                                }
                            })
                        }
                        .coordinateSpace(name: "BottomSheetCoordinateSpace")
                        .transition(.fadeQuickly(from: 0, to: 1))
                    } else {
                        //Spacer()
                        content
                            .frame(maxWidth: .infinity)
                            .transition(.fadeOutLate(from: 0, to: 1).combined(with: .offset(y: transitionOffset)))
                    }
                }
                .frame(width: width, height: maxHeight, alignment: .top)
            }
            .frame(height: maxHeight, alignment: .bottom)
            .offset(y: max(detent.topOffset(in: height) + translation + detent.transientAnimationOffset, detent.topGap))
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let offset = detent.topOffset(in: height)
                        let endTranslation = value.predictedEndTranslation.height
                        detent = detent.with(transientAnimationOffset: value.translation.height)
                        let newDetent = closestDetent(to: offset + endTranslation,
                                                      in: height,
                                                      detents: detents)
                        transitionOffset = newDetent.topOffset(in: height) - offset - value.translation.height
                        withAnimation(.interactiveSpring(response: 0.27, dampingFraction: 0.8, blendDuration: 0.25)) {
                            detent = newDetent
                        }
                    })
        }
        .background(dimView)
    }
    
    @ViewBuilder private var dimView: some View {
        if detent.dimBackground, detent.isVisible {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.27, dampingFraction: 0.8, blendDuration: 0.25)) {
                        detent = .hidden
                    }
                }
        } else {
            if style.allowBackgroundInteraction || detent.isHidden {
                EmptyView()
            } else {
                Color.black.opacity(0.0001)
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.27, dampingFraction: 0.8, blendDuration: 0.25)) {
                            detent = .hidden
                        }
                    }
                    .allowsHitTesting(true)
            }
        }
    }
    
    private func transitionToNextDetent(containerHeight: CGFloat) {
        
        let detentTuples = detents.map { detent in
            (offset: detent.topOffset(in: containerHeight), detent: detent)
        }
        
        let sortedDetents = detentTuples.sorted { a, b in
            a.offset < b.offset
        }.map(\.detent)
        
        let currentIndex: Int = sortedDetents.firstIndex(where: { $0.sheetHeight == detent.sheetHeight }) ?? 0
        let after = min(currentIndex + 1, detents.count - 1)
        let nextDetent = sortedDetents[after]

        transitionOffset = -(nextDetent.topOffset(in: containerHeight) - detent.topOffset(in: containerHeight))
        
        withAnimation(.interactiveSpring(response: 0.27, dampingFraction: 0.8, blendDuration: 0.25)) {
            detent = nextDetent
        }
    }
        
    private func closestDetent(to currentOffset: CGFloat,
                               in containerHeight: CGFloat,
                               detents: [BottomSheetDetent]) -> BottomSheetDetent {
        var detentsByDistance: [Int: BottomSheetDetent] = [:]
        
        let detentTuples = detents.map { detent in
            (offset: detent.topOffset(in: containerHeight), detent: detent)
        }
        
        let sortedDetents = detentTuples.sorted { a, b in
            a.offset < b.offset
        }
        
        let currentIndex: Int = sortedDetents.firstIndex(where: { $0.detent.sheetHeight == detent.sheetHeight }) ?? 0
        let before = max(0, currentIndex - 1)
        let after = min(currentIndex + 1, detents.count - 1)
                
        // We only want to consider the closest intent before and after
        // the current detent, so that the snapping doesn't skip a detent.
        let eligibleDetents = sortedDetents[before...after]

        for detent in eligibleDetents {
            let distance = Int(abs(detent.offset - currentOffset))
            detentsByDistance[distance] = detent.detent
        }
        guard let key = detentsByDistance.keys.min(),
              let newDetent = detentsByDistance[key] else {
            return .large
        }
        return newDetent
    }
}

// MARK: - Detent Transitions

struct FadeQuicklyModifier: AnimatableModifier {

    var t: Double
    
    var animatableData: Double {
        get { return t }
        set { t = newValue }
    }

    func body(content: Content) -> some View {
        content.opacity(t > 0.95 ? 1 : 0)
    }
}

extension AnyTransition {
    static func fadeQuickly(from: Double, to: Double) -> AnyTransition {
        .modifier(
            active: FadeQuicklyModifier(t: from),
            identity: FadeQuicklyModifier(t: to)
        )
    }
}

struct FadeOutLateModifier: AnimatableModifier {

    var t: Double
    
    var animatableData: Double {
        get { return t }
        set { t = newValue }
    }

    func body(content: Content) -> some View {
        content.opacity(t > 0.05 ? 1 : 0)
    }
}

extension AnyTransition {
    static func fadeOutLate(from: Double, to: Double) -> AnyTransition {
        .modifier(
            active: FadeOutLateModifier(t: from),
            identity: FadeOutLateModifier(t: to)
        )
    }
}

// MARK: - BottomSheet + No Header

extension BottomSheet where Header == EmptyView {
    
    public init(detent: Binding<BottomSheetDetent>, @ViewBuilder content: () -> Content) {
        self._detent = detent
        self.header = EmptyView()
        self.content = content()
    }
}


// MARK: - Bottom Sheet Style

public struct BottomSheetStyle {
    
    public let detents: [BottomSheetDetent]
    public let dragIndicator: Bool
    public let dragIndicatorColor: Color
    public let backgroundColor: Color
    public let allowBackgroundInteraction: Bool
    public let dropShadow: Bool
    public let contentScrolls: Bool

    public init(
        detents: [BottomSheetDetent]? = nil,
        dragIndicator: Bool? = nil,
        dragIndicatorColor: Color? = nil,
        backgroundColor: Color? = nil,
        allowBackgroundInteraction: Bool? = nil,
        dropShadow: Bool? = nil,
        contentScrolls: Bool? = nil
    ) {
        self.detents = detents?.filter { $0.isVisible } ?? [.large, .medium, .small, .minimal]
        self.dragIndicator = dragIndicator ?? true
        self.dragIndicatorColor = dragIndicatorColor ?? Color(UIColor.systemGray4)
        self.backgroundColor = backgroundColor ?? Color(UIColor.systemBackground)
        self.allowBackgroundInteraction = allowBackgroundInteraction ?? false
        self.dropShadow = dropShadow ?? true
        self.contentScrolls = contentScrolls ?? false
    }
    
    public func with(
        detents: [BottomSheetDetent]? = nil,
        dragIndicator: Bool? = nil,
        dragIndicatorColor: Color? = nil,
        backgroundColor: Color? = nil,
        allowBackgroundInteraction: Bool? = nil,
        dropShadow: Bool? = nil,
        contentScrolls: Bool? = nil
    ) -> BottomSheetStyle {
        BottomSheetStyle(
            detents: detents ?? self.detents,
            dragIndicator: dragIndicator ?? self.dragIndicator,
            dragIndicatorColor: dragIndicatorColor ?? self.dragIndicatorColor,
            backgroundColor: backgroundColor ?? self.backgroundColor,
            allowBackgroundInteraction: allowBackgroundInteraction ?? self.allowBackgroundInteraction,
            dropShadow: dropShadow ?? self.dropShadow,
            contentScrolls: contentScrolls ?? self.contentScrolls)
    }
    
    public static let defaultStyle = BottomSheetStyle()
    
    public static let defaultScrollingStyle = BottomSheetStyle(contentScrolls: true)
}

fileprivate struct BottomSheetStyleKey: EnvironmentKey {
    static let defaultValue = BottomSheetStyle.defaultStyle
}

fileprivate extension EnvironmentValues {
    var bottomSheetStyle: BottomSheetStyle {
        get {
            return self[BottomSheetStyleKey.self]
        }
        set {
            self[BottomSheetStyleKey.self] = newValue
        }
    }
}

// MARK: - Bottom Sheet Style Modifier

public struct BottomSheetStyleModifier: ViewModifier {
    public let value: BottomSheetStyle
    public init(value: BottomSheetStyle) {
        self.value = value
    }
    public func body(content: Content) -> some View {
        content.environment(\.bottomSheetStyle, value)
    }
}

extension View {
    func bottomSheetStyle(_ value: BottomSheetStyle) -> some View {
        self.modifier(BottomSheetStyleModifier(value: value))
    }
}

#endif
