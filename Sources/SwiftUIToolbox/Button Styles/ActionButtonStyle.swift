//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .padding(EdgeInsets(top: 2, leading: 10, bottom: 4, trailing: 10))
        .foregroundColor(configuration.isPressed ? Color.white : Color.accentColor)
        .background(configuration.isPressed ? Color.blue : Color(.sRGB, red: 0.95, green: 0.95, blue: 0.97, opacity: 1))
        .cornerRadius(.infinity)
    }
}

struct BorderedButton_Preview: PreviewProvider {
  static var previews: some View {
    Group {
        Button(action: { }) {
            Text("Open")
                
        }.buttonStyle(ActionButtonStyle())
    }
    .previewLayout(.sizeThatFits)
    .padding(10)
    .background(Color.white)
  }
}
