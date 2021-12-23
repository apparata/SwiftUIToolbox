//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if os(iOS)

import SwiftUI
import UIKit

extension View {

    /// Display a popover from the top toolbar.
    ///
    /// Example:
    ///
    /// ```
    /// struct ContentView: View {
    ///
    ///     @State var date: Date = Date()
    ///
    ///     @State var isShowingPopover: Bool = false
    ///
    ///     var body: some View {
    ///         NavigationView {
    ///             Text("Hello, World!")
    ///                 .navigationTitle("Stuff")
    ///                 .toolbar {
    ///                     ToolbarItem(placement: .navigationBarLeading) {
    ///                         Button {
    ///                             withAnimation(.easeInOut(duration: 0.2)) {
    ///                                 isShowingPopover.toggle()
    ///                             }
    ///                         } label: {
    ///                             Image(systemName: "star")
    ///                         }
    ///                     }
    ///                 }
    ///         }
    ///         .toolbarPopover(showing: $isShowingPopover, placement: .leading) {
    ///             DatePicker("", selection: $date)
    ///                 .labelsHidden()
    ///         }
    ///     }
    /// }
    /// ```
    public func toolbarPopover<Content: View>(showing: Binding<Bool>, placement: ToolbarPopoverPlacement, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(ZStack(alignment: placement == .leading ? .topLeading : .topTrailing) {
                if showing.wrappedValue {
                    ToggleOnTap(showing: showing)
                        .ignoresSafeArea()
                    VStack {
                        content()
                            .padding()
                            .background(Color(.systemBackground).clipShape(PopoverArrowShape(placement: placement)))
                            .shadow(color: .primary.opacity(0.05), radius: 5, x: 5, y: 5)
                            .shadow(color: .primary.opacity(0.05), radius: 5, x: -5, y: -5)
                            .padding(.horizontal, 35)
                            .offset(y: 55)
                            .offset(x: placement == .leading ? -20 : 20)
                    }
                    Spacer()
                }
            }, alignment: placement == .leading ? .topLeading : .topTrailing)
    }
}

public enum ToolbarPopoverPlacement {
    case leading
    case trailing
}

fileprivate class TransparentTapAreaView: UIControl {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
}

fileprivate struct ToggleOnTap: UIViewRepresentable {
    
    @Binding var showing: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = TransparentTapAreaView()
        view.backgroundColor = .clear
        view.addAction(.init { _ in
            withAnimation(.easeInOut(duration: 0.2)) {
                showing = false
            }
        }, for: .touchDown)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct PopoverArrowShape: Shape {
    
    var placement: ToolbarPopoverPlacement
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let p1 = CGPoint(x: 0, y: 0)
            let p2 = CGPoint(x: rect.width, y: 0)
            let p3 = CGPoint(x: rect.width, y: rect.height)
            let p4 = CGPoint(x: 0, y: rect.height)
            
            path.move(to: p4)
            
            path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
            path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
            path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
            path.addArc(tangent1End: p4, tangent2End: p1, radius: 15)
            
            path.move(to: p1)
            
            path.addLine(to: CGPoint(x: placement == .leading ? 10 : rect.width - 10, y: 0))
            path.addLine(to: CGPoint(x: placement == .leading ? 15 : rect.width - 15, y: 0))
            path.addLine(to: CGPoint(x: placement == .leading ? 25 : rect.width - 25, y: -15))
            path.addLine(to: CGPoint(x: placement == .leading ? 40 : rect.width - 40, y: 0))
        }
    }
}

struct ToolbarPopover_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#endif
