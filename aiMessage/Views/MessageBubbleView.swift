//
//  MessageBubbleView.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/8/26.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer() // pushes to right
            }
            Text(.init(message.text))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.isUser ? Color(red: 8/255, green: 127/255, blue: 254/255) : Color.gray.opacity(0.2))
                .foregroundStyle(message.isUser ? .white : .black)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .frame(maxWidth: 250, alignment: message.isUser ? .trailing : .leading)
            
            
            if !message.isUser {
                Spacer() // pushes to left
            }
            
        }
    }
}

#Preview {
    MessageBubbleView(message: ChatMessage(text: "Good morning, Good morning, Good morning, Good morning", isUser: true))
}
