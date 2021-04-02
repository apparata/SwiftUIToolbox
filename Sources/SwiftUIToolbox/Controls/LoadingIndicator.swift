//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

public struct LoadingIndicator: View {
    
    @State var t: CGFloat = 0
    
    public init() {
        //
    }
    
    public var body: some View {
        LoadingShape(t: t)
            .frame(width: 60, height: 30)
            .onAppear {
                // Workaround for incorrect animations if
                // view is used inside a NavigationView.
                DispatchQueue.main.async {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        t = 3
                    }
                }
            }
    }
}

public struct LoadingShape: Shape {
    
    var t: CGFloat
    
    public var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }
    
    public init(t: CGFloat) {
        self.t = t
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let radius = rect.width / 10
        let diameter = 2 * radius

        let dots: [(x: CGFloat, delay: CGFloat)] = [
            (x: radius, delay: 0),
            (x: radius * 5, delay: 0.35),
            (x: radius * 9, delay: 0.7)
        ]
        
        for dot in dots {
            let k = scale(t, delay: dot.delay)
            let center = CGPoint(x: dot.x, y: rect.midY)
            let size = CGSize(width: diameter * k, height: diameter * k)
            let circle = CGRect(center: center, size: size)
            path.addEllipse(in: circle)
        }
        
        return path
    }
    
    func scale(_ t: CGFloat, delay: CGFloat) -> CGFloat {
        let angle: CGFloat = min(1, max(0, t - delay)) * 2 * .pi - .pi / 2
        let k = 0.5 + 0.5 * sin(angle)
        return 1 + 0.4 * k
    }
}

fileprivate extension CGRect {
    
    init(center: CGPoint, size: CGSize) {
        self.init()
        self.size = size
        self.origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
            .foregroundColor(.systemGray5)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

