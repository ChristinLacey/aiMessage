//
//  ContentView.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var textInput: String = ""
    @State private var isTyping: Bool = false
    @State private var messages = [
        ChatMessage(text: "Good morning", isUser: true),
        ChatMessage(text: "Hello, how are you?", isUser: false),
        ChatMessage(text: "I'm doing well, thanks for asking!", isUser: true)
    ]
    var body: some View {
        VStack {
            Text("aiMessage")
                .font(.largeTitle)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer() // pushes to right
                                }
                                Text(message.text)
                                    .padding(8)
                                    .background(message.isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                                    .id(message.id)
                                
                                if !message.isUser {
                                    Spacer() // pushes to left
                                }
                                
                            }
                            
                        }
                        if isTyping {
                            HStack {
                                Text("...")
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) {
                    if let last = messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
            HStack {
                TextField("Enter a message", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    sendMessage()
                }
            }
            .padding()
        }
    }
    
    func sendMessage() {
        guard !textInput.isEmpty else { return }
        
        let userMessage = ChatMessage(text: textInput, isUser: true)
        messages.append(userMessage)
        
        textInput = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            isTyping = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = ChatMessage(text: "Your message was received!", isUser: false)
            isTyping = false
            messages.append(aiResponse)
        }
    }
}

#Preview {
    ContentView()
}
