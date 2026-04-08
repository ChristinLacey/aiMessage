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
        ChatMessage(text: "Hello, how are you? Good morning Good morning Good morning Good morning", isUser: false),
        ChatMessage(text: "I'm doing well, thanks for asking!", isUser: true)
    ]
    var trimmedInput: String {
        textInput.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("aiMessage")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 8)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubbleView(message: message)
                                .id(message.id)
                        }
                        if isTyping {
                            MessageBubbleView(message: ChatMessage(text: "...", isUser: false))
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
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(trimmedInput.isEmpty ? Color.blue.opacity(0.5) : Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(16)
                .disabled(trimmedInput.isEmpty)
            }
            .padding()
        }
    }
    
    func sendMessage() {
        guard !trimmedInput.isEmpty else { return }
        
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
