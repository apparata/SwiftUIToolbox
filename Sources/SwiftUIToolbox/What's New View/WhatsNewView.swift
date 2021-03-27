//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

public struct WhatsNewView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let whatsNew: WhatsNew
    
    public init(_ whatsNew: WhatsNew) {
        self.whatsNew = whatsNew
    }
    
    public var body: some View {
        VStack {
            Spacer()
            WhatsNewTitle(welcome: whatsNew.welcome,
                            appName: whatsNew.appName)
            WhatsNewHintRows(hints: whatsNew.hints)
                .padding(.top, 10)
            Spacer(minLength: 30)
            Button(whatsNew.continueButton, action: continueFromWhatsNew)
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
                .padding([.horizontal, .bottom])
        }
    }
    
    private func continueFromWhatsNew() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        presentationMode.wrappedValue.dismiss()
    }
}

struct WhatsNew_Previews: PreviewProvider {

    static var previews: some View {
        let whatsNew = WhatsNew(appName: "Preview", hints: [])
        Group {
            WhatsNewView(whatsNew)
                .previewDevice("iPhone 11 Pro")
            WhatsNewView(whatsNew)
                .previewLayout(.device)
                .previewDevice("iPhone 12 mini")
            WhatsNewView(whatsNew)
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}

private struct WhatsNewTitle: View {
    
    let welcome: String
    
    let appName: String

    var body: some View {
        VStack {
            WhatsNewTitleText(welcome)
            WhatsNewTitleText(appName)
                .foregroundColor(.accentColor)
        }
    }
}

private struct WhatsNewHintRows: View {
    
    let hints: [WhatsNew.Hint]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(hints) { hint in
                WhatsNewHintRow(title: hint.title,
                                subtitle: hint.subtitle,
                                icon: hint.icon)
            }
        }
        .padding(.horizontal)
    }
}

private struct WhatsNewHintRow: View {
    
    let title: String
    
    let subtitle: String
    
    let icon: String

    var body: some View {
        HStack(alignment: .top) {
            hintIcon
            VStack(alignment: .leading, spacing: 4) {
                hintTitle
                hintSubtitle
            }
            .padding(.trailing, 8)
        }
        .padding(.top)
    }
    
    var hintIcon: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding(.vertical, 4)
                .padding(.horizontal)
                .accessibility(hidden: true)
        }.frame(width: 60)
    }
    
    var hintTitle: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
            .accessibility(addTraits: .isHeader)
    }
    
    var hintSubtitle: some View {
        Text(subtitle)
            .font(.body)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private struct WhatsNewTitleText: View {
    
    private let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}
