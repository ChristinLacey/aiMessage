//
//  TypingIndicatorView.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/11/26.
//

import SwiftUI

struct TypingIndicatorView: View {
    @State private var animate = false
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .opacity(animate ? 0.5 : 0)
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever(),
                    value: animate
                )
            Circle()
                .frame(width: 8, height: 8)
                .opacity(animate ? 0.5 : 0)
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever()
                    .delay(0.15),
                    value: animate
                )
            Circle()
                .frame(width: 8, height: 8)
                .opacity(animate ? 0.5 : 0)
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever()
                    .delay(0.3),
                    value: animate
                )
        }
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: 250, alignment: .leading)
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    TypingIndicatorView()
}
