//
//  ContentView.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var textInput: String = ""
    @State private var messages = [
        ChatMessage(text: "Good morning", isUser: true),
        ChatMessage(text: "Hello, how are you?", isUser: false),
        ChatMessage(text: "I'm doing well, thanks for asking!", isUser: true)
    ]
    var body: some View {
        VStack {
            Text("aiMessage")
                .font(.largeTitle)
            
            ForEach(messages) { message in
                HStack {
                    if message.isUser {
                        Spacer() // pushes to right
                    }
                    Text(message.text)
                        .background(message.isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(8)
                    
                    if !message.isUser {
                        Spacer() // pushes to left
                    }
                }
                
            }
            HStack {
                TextField("Enter a message", text: $textInput)
                Button("Send") {
                    sendMessage()
                }
            }
        }
        Spacer()
    }
    
    func sendMessage() {
        guard !textInput.isEmpty else { return }
        
        let newMessage = ChatMessage(text: textInput, isUser: true)
        messages.append(newMessage)
        
        textInput = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = ChatMessage(text: "Your message was received!", isUser: false)
            messages.append(aiResponse)
        }
    }
}

#Preview {
    ContentView()
}
